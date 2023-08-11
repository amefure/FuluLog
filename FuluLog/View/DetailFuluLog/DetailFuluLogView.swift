//
//  DetailFuluView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/11.
//

import SwiftUI
import WidgetKit
import RealmSwift

struct DetailFuluLogView: View {
    
    // MARK: - ViewModels
    private let realmDataBase = RealmDataBaseViewModel()
    private let userDefaults = UserDefaultsViewModel()
    private let deviceSize = DeviceSizeViewModel()
    private let displayDate = DisplayDateViewModel()
    
    // MARK: - Environment
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Receive
    @State var item:FuluLogRecord
    
    // MARK: - Models
    @ObservedResults(FuluLogRecord.self) var allFuleRelam
    @ObservedResults(FavoriteFuluLogRecord.self) var allFavoriteFuluLogRecord
    
    // MARK: - View
    @State var isModal:Bool = false
    @State var isAlertDelete:Bool = false
    @State var isOn:Bool // ワンストップ申請トグルボタン
    
    var isFavorite:Bool // Favoriteからの呼出
    
    
    // MARK: - Method
    private  func updateItem(){
        if let result = allFuleRelam.first(where: { $0.id == item.id }){
            self.item = result
        }else{
            if let result2 = allFavoriteFuluLogRecord.first(where: { $0.id == item.id }){
                self.item = result2
            }
        }
        
    }
    
    private func updateAppGroupandWidget(){
        let year = displayDate.nowYearString()
        let array = allFuleRelam.filter({$0.request == false && $0.timeString.contains(year) })
        userDefaults.setCountKey(count: array.count)
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
                            EntryFavoriteBtnView(item: item)
                        }
                        
                    }
                    // MARK: -
                    HStack{
                        Text("寄付した自治体：")
                        Text(item.municipality)
                        Spacer()
                        Text(item.timeString)
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
                }.frame(width:deviceSize.deviceWidth - 30).background(Color("BaseColor")).cornerRadius(5)
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
                        HStack{
                            Text("ワンストップ申請発送")
                            Image(systemName: isOn == true ? "checkmark.seal.fill" : "checkmark.seal")
                                .foregroundColor(isOn == true ? .orange : .gray)
                        }
                    }.padding(.vertical)
                        .padding(.trailing,10)
                        .tint(.orange)
                        .onChange(of: isOn) { newValue in
                            realmDataBase.updateRecord(id: item.id, productName: item.productName, amount: item.amount, municipality: item.municipality, url: item.url, memo: item.memo, request: isOn, time: item.time)
                            // MARK: - ワンストップ申請の変更を反映する
                            updateAppGroupandWidget()
                        }
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
                    .foregroundColor(Color("ThemaColor"))
                    .cornerRadius(5)
                // MARK: - DeleteBtn
                
            } // ScrollView
            
            // MARK: - AdMob
            AdMobBannerView().frame(height: 40).padding(.vertical)
            
        } // Vstack
        .textSelection(.enabled)
        .padding(.horizontal)
        .navigationBarHidden(true)
        // MARK: - DeleteAlert
        .alert(Text(isFavorite ? "お気に入りを解除しますか？" : "寄付情報を削除しますか？"),isPresented: $isAlertDelete){
            Button(role: .destructive, action: {
                withAnimation(.linear(duration: 0.3)){
                    if isFavorite == false {
                        realmDataBase.deleteRecord(id: item.id)
                    }else{
                        // MARK: - Favorite
                        realmDataBase.favorite_deleteRecord(id: item.id)
                    }
                    dismiss()
                }
            }, label: {
                Text(isFavorite ? "解除する" : "削除する")
            })
        } message: {
            
        }
        // MARK: - UpdateModal
        .sheet(isPresented: $isModal, content: {
            UpdateFuluLogView(item: item,isModal:$isModal,parentUpdateItemFunction: updateItem,isFavorite: isFavorite)
        })
    }
}
