//
//  DetailFuluView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/11.
//

import SwiftUI

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
    @State var isAlertUpdate:Bool = false
    @State var isOn:Bool
    
    var deviceWidth = UIScreen.main.bounds.width
    
    // MARK: - Method
    func updateItem(_ data:FuluLog){
        self.item = data
    }
    
    // シェアボタン
    func shareApp(shareText: String, shareLink: String) {
        let items = [shareText, URL(string: shareLink)!] as [Any]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popPC = activityVC.popoverPresentationController {
                popPC.sourceView = activityVC.view
                popPC.barButtonItem = .none
                popPC.sourceRect = activityVC.accessibilityFrame
            }
        }
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let rootVC = windowScene?.windows.first?.rootViewController
        rootVC?.present(activityVC, animated: true,completion: {})
    }
    
    var body: some View {
        VStack{
            
            // MARK: - Header
            HeaderView(headerTitle: item.productName,leftImageName: "chevron.backward",rightImageName: "square.and.pencil", parentLeftButtonFunction: {dismiss()}, parentRightButtonFunction: { isModal = true})
            
            
            // MARK: - productName / municipality / time
            VStack(alignment:.leading){
                HStack{
                    Text(item.productName).font(.system(size: 20)).fontWeight(.bold)
                    Spacer()
                    // MARK: ShareBtn
                    Button(action: {
                        shareApp(shareText: "ふるさと納税「\(item.productName)」がおすすめだよ！\n\(item.url)", shareLink: item.url)
                    }, label: {
                        Image(systemName: "square.and.arrow.up")
                    })
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
                Link(destination: {
                    URL(string: item.url)!
                }(), label: {
                    HStack{
                        Text("\(item.url)")
                        Image(systemName: "link")
                    }
                })
            }.padding(.vertical)
            // MARK: - url
            
            Spacer()
            
            // MARK: - ワンストップ申請発送
            Toggle(isOn: $isOn) {
                Text("ワンストップ申請発送")
                Image(systemName: isOn == true ? "checkmark.seal.fill" : "checkmark.seal")
                    .foregroundColor(isOn == true ? .orange : .gray)
            }.padding(.vertical)
                .tint(.orange)
            // MARK: - ワンストップ申請発送
            
            Spacer()
            
            // MARK: - DeleteBtn
            Button(action: {
                isAlertDelete = true
            }, label: {
                HStack{
                    Image(systemName: "trash.fill")
                    Text("寄付情報を削除する")
                }
            }).padding()
                .background(Color("SubColor"))
                .foregroundColor(Color("ThemaColor")).cornerRadius(5)
            // MARK: - DeleteBtn
           
            
            // MARK: - AdMob
            AdMobBannerView().frame(width:UIScreen.main.bounds.width,height: 40).padding(.vertical)
            
        } // Vstack
        .padding(.horizontal)
        .navigationBarHidden(true)
        // MARK: - DeleteAlert
        .alert(isPresented: $isAlertDelete){
            Alert(title:Text("寄付情報を削除しますか？"),
                  message: Text(""),
                  primaryButton: .destructive(Text("削除する"),
                                              action: {
                withAnimation(.linear(duration: 0.3)){
                    allFulu.removeData(item)   // 選択されたitemを削除
                    fileController.updateJson(allFulu.allData) // JSONファイルを更新
                    allFulu.setAllData() // JSONファイルをプロパティにセット
                    dismiss()
                }
            }), secondaryButton: .cancel(Text("キャンセル")))
        }
        // MARK: - UpdateModal
        .sheet(isPresented: $isModal, content: {
            UpdateFuluLogView(item: item,isModal:$isModal,parentUpdateItemFunction: updateItem)
        })
        // MARK: - ワンストップ申請の変更を反映する
        .onDisappear(perform: {
            let data = FuluLog(productName: item.productName, amount: item.amount, municipality: item.municipality, url: item.url,memo: item.memo,request: isOn)
            allFulu.updateData(data,item.id)
            fileController.updateJson(allFulu.allData) // JSONファイルを更新
            allFulu.setAllData()
        })
        
    }
}

struct DetailFuluView_Previews: PreviewProvider {
    static var previews: some View {
        DetailFuluLogView(item: FuluLog(productName: "", amount: 0, municipality: "", url: ""),isOn: true)
    }
}
