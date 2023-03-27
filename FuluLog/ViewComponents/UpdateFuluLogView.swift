//
//  UpdateFuluView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/11.
//

import SwiftUI

struct UpdateFuluLogView: View {
    
    // MARK: - ViewModels
    private let validation = ValidationViewModel()
    private let realmDataBase = RealmDataBaseViewModel()
    private let userDefaults = UserDefaultsViewModel()
    
    // MARK: - Models
    @EnvironmentObject var allFulu:AllFuluLog
    var fileController = FileController()
    
    // MARK: - TextField
    @State var productName:String = ""     // 商品名
    @State var amount:Int = -1             // 金額情報
    @State var municipality:String = ""    // 自治体
    @State var url:String = ""             // URL
    @State var memo:String = ""            // メモ
//    @State var time:Date = Date()
    @State var time:String = {             // 初期値に現在の日付
        let str = DisplayDateViewModel().getDateDisplayFormatString(Date())
        return str
    }()
    
    // MARK: - View
    @State var isAlert:Bool = false     // 新規登録/更新処理を実行したアラート
    
    // MARK: - Receive
    var item:FuluLogRecord
    
    @Binding var isModal:Bool
    // 親メソッドを受けとる
    var parentUpdateItemFunction: () -> Void
    
    var isFavorite:Bool // Favoriteからの呼出
    
    // disable:Bool true→非アクティブ false→OK
    private func validatuonInput() -> Bool{
         // 必須入力は商品名と寄付金額のみ
         if self.validation.validatuonInput(productName) && self.validation.validatuonAmount(amount)  {
             if self.validation.validatuonInput(url){ // 入力値があるならバリデーション
                 if self.validation.validationUrl(url) {
                     return false // URL 有効 OK
                 }
                 return true // URL 無効 NG
             }else{
                 return false // 必須事項記入あり　URL 入力なし OK
             }
         }
         return true // 必須事項記入なし NG
     }
    
    func deleteInput(){
        productName = ""     // 商品名
        amount = -1          // 金額情報
        municipality = ""    // 自治体
        url = ""             // URL
        memo = ""            // メモ
        time = ""            // 日付
    }
    
    var body: some View {
        VStack{
            // MARK: - Input
            InputFuluLogView(productName: $productName, amount: $amount, municipality: $municipality, url: $url, memo: $memo,time: $time)
            
            // MARK: - UpdateBtn
            Button(action: {
                withAnimation(.linear(duration: 0.3)){
                    
//                let data = FuluLogRecord(productName: productName, amount: amount, municipality: municipality, url: url,memo: memo,time: time)
                    
                    
                    if isFavorite == false {
                        // MARK: - FuluLog
                        realmDataBase.updateRecord(id: item.id, productName: productName, amount: amount, municipality: municipality, url: url,memo: memo, request: item.request,time:DisplayDateViewModel().getConvertStringDate(time))
//                        allFulu.updateData(data,item.id)
//                        fileController.updateJson(allFulu.allData) // JSONファイルを更新
//                        allFulu.setAllData()
                        
                    }else{
                        // MARK: - Favorite
                        realmDataBase.favorite_updateRecord(id: item.id, productName: productName, amount: amount, municipality: municipality, url: url,memo: memo, request: item.request,time:DisplayDateViewModel().getConvertStringDate(time))
//                        allFulu.updateFavoriteData(data,item.id)
//                        fileController.updateFavoriteJson(allFulu.allFavoriteData) // JSONファイルを更新
//                        allFulu.setAllFavoriteData() // JSONファイルをプロパティにセット
                        
                    }
//                allFulu.createTimeArray()
                    parentUpdateItemFunction()
                isAlert = true
                }
            }, label: {
                Text("更新")
            }).padding() // ボタンパディング用
                .disabled(validatuonInput())
                .background(validatuonInput() ? Color(red: 0.8, green: 0.8, blue: 0.8) : Color("SubColor") )
                .foregroundColor(validatuonInput() ? Color.black : Color("ThemaColor"))
                .cornerRadius(5)
                .padding(.bottom) // 下部余白用
            // MARK: - UpdateBtn
            
            Spacer()
            
        }
        .background(Color("FoundationColor"))
        .onAppear(){ // 初期値格納用
            productName = item.productName     // 商品名
            amount = item.amount               // 金額情報
            municipality = item.municipality   // 自治体
            url = item.url                     // URL
            memo = item.memo                   // メモ
            time = item.timeString                 // 日付
        }
        .alert(Text("更新しました。"),
               isPresented: $isAlert,
               actions: {
            Button(action: {
                deleteInput()
                isModal = false
            }, label: {
                Text("OK")
            })
        }, message: {
            Text("")
        })
    }
}


