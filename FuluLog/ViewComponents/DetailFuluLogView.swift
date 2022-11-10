//
//  DetailFuluView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/11.
//

import SwiftUI
import WidgetKit

struct DetailFuluLogView: View {
    
    
    // MARK: - Models
    let fileController = FileController()
    @EnvironmentObject var allFulu:AllFuluLog
    
    // MARK: - Environment
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Receive
    @State var item:FuluLog
    
    // MARK: - View
    @State var isModal:Bool = false
    @State var isAlertDelete:Bool = false
    @State var isOn:Bool // ワンストップ申請トグルボタン
    
    var isFavorite:Bool // Favoriteからの呼出
    
    var deviceWidth = UIScreen.main.bounds.width
    
    // MARK: - Method
    func updateItem(_ data:FuluLog){
        self.item = data
    }
    
    func test(){
        let df = DateFormatter()
        df.dateFormat = "yyyy"
        df.locale = Locale(identifier: "ja_JP")
        let year = df.string(from: Date())
        let array = allFulu.allData.filter({$0.request == false && $0.time.contains(year) })
        UserDefaults(suiteName: "group.com.ame.FuluLog")?.set(array.count, forKey: "count")
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    
    var body: some View {
        VStack{
            
            // MARK: - Header
            HeaderView(headerTitle: item.productName,leftImageName: "chevron.backward",rightImageName: "square.and.pencil", parentLeftButtonFunction: {dismiss()}, parentRightButtonFunction: { isModal = true})
            
            ScrollView{
                
                // MARK: - productName / municipality / time
                VStack(alignment:.leading){
                    HStack{
                        Text(item.productName).font(.system(size: 20)).fontWeight(.bold)
                        Spacer()
                        
                        // MARK: - ShareBtn
                        ShareBtnView(item: item)
                        
                        // MARK: - EntryFavoriteBtn
                        if isFavorite == false{
                            EntryFavoriteBtnView(item: item).environmentObject(allFulu)
                        }
                       
                    }
                    // MARK: -
                    HStack{
                        Text("寄付した自治体：")
                        Text(item.municipality)
                        Spacer()
                        Text(item.time)
                    }.font(.system(size: 15)).padding(.vertical,5).foregroundColor(.gray)
                    Rectangle().fill(.gray).frame(height: 2).opacity(0.5)
                }.padding(.vertical)
                // MARK: - productName / municipality / time
                
                // MARK: - amount
                HStack{
                    Text("\(item.amount)").font(.system(size: 35)).foregroundColor(.orange)
                    Text("円").font(.system(size: 20)).offset(x: 0, y: 5)
                }.padding(.bottom)
                // MARK: - amount
                
                // MARK: - memo
                HStack(){
                    Text(item.memo).foregroundColor(.gray).padding()
                    Spacer()
                }.frame(width:UIScreen.main.bounds.width - 30).background(Color("BaseColor"))
                // MARK: - memo
                
                
                // MARK: - url
                HStack{
                    Text("購入URL：")
                    if item.url.isEmpty{
                        Text("URL未登録")
                    }else{
                        Link(destination: {
                            URL(string: item.url)!
                        }(), label: {
                            HStack{
                                Text("\(item.url)")
                                Image(systemName: "link")
                            }
                        })
                    }
                }.padding(.vertical)
                // MARK: - url
                
                Spacer()
                
                // MARK: - ワンストップ申請発送
                if isFavorite == false {
                    Toggle(isOn: $isOn) {
                        Text("ワンストップ申請発送")
                        Image(systemName: isOn == true ? "checkmark.seal.fill" : "checkmark.seal")
                            .foregroundColor(isOn == true ? .orange : .gray)
                    }.padding(.vertical)
                        .tint(.orange)
                }
                // MARK: - ワンストップ申請発送
                
                Spacer()
                
                // MARK: - DeleteBtn
                Button(action: {
                    isAlertDelete = true
                }, label: {
                    HStack{
                        Image(systemName: isFavorite ? "star.slash" :"trash.fill")
                        Text(isFavorite ? "お気に入りを解除する" : "寄付情報を削除する")
                    }
                }).padding()
                    .background(Color("SubColor"))
                    .foregroundColor(Color("ThemaColor")).cornerRadius(5)
                // MARK: - DeleteBtn
                
            } // ScrollView
            
            // MARK: - AdMob
            AdMobBannerView().frame(width:UIScreen.main.bounds.width,height: 40).padding(.vertical)
            
        } // Vstack
        .textSelection(.enabled)
        .padding(.horizontal)
        .navigationBarHidden(true)
        // MARK: - DeleteAlert
        .alert(Text(isFavorite ? "お気に入りを解除しますか？" : "寄付情報を削除しますか？"),
               isPresented: $isAlertDelete,
               actions: {
            Button(role: .destructive, action: {
                withAnimation(.linear(duration: 0.3)){
                    if isFavorite == false {
                        // MARK: - FuluData
                        allFulu.removeData(item)   // 選択されたitemを削除
                        fileController.updateJson(allFulu.allData) // JSONファイルを更新
                        allFulu.setAllData() // JSONファイルをプロパティにセット
                    }else{
                        // MARK: - Favorite
                        allFulu.removeFavoriteData(item)   // 選択されたitemを削除
                        fileController.updateFavoriteJson(allFulu.allFavoriteData) // JSONファイルを更新
                        allFulu.setAllFavoriteData() // JSONファイルをプロパティにセット
                    }
                    dismiss()
                }
            }, label: {
                Text(isFavorite ? "解除する" : "削除する")
            })
        }, message: {
            Text("")
        })
        // MARK: - UpdateModal
        .sheet(isPresented: $isModal, content: {
            UpdateFuluLogView(item: item,isModal:$isModal,parentUpdateItemFunction: updateItem,isFavorite: isFavorite)
        })
        // MARK: - ワンストップ申請の変更を反映する
        .onDisappear(perform: {
            
            if isFavorite == false {
                let data = FuluLog(productName: item.productName, amount: item.amount, municipality: item.municipality, url: item.url,memo: item.memo,request: isOn, time:item.time)
                allFulu.updateData(data,item.id)
                fileController.updateJson(allFulu.allData) // JSONファイルを更新
                allFulu.setAllData()
                test()
            }
        })
        
    }
}

struct DetailFuluView_Previews: PreviewProvider {
    static var previews: some View {
        DetailFuluLogView(item: FuluLog(productName: "", amount: 0, municipality: "", url: ""),isOn: true,isFavorite: false)
    }
}
