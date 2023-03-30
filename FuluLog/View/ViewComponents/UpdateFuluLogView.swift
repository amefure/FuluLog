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
    private let displayDate = DisplayDateViewModel()
    
    // MARK: - TextField
    @State var productName:String = ""     // 商品名
    @State var amount:Int = -1             // 金額情報
    @State var municipality:String = ""    // 自治体
    @State var url:String = ""             // URL
    @State var memo:String = ""            // メモ
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
        validation.checkInputValidity(text: productName, amount: amount, urlStr: url)
    }
    
    private func resetInputData(){
        productName = ""     // 商品名
        amount = -1           // 金額情報
        municipality = ""    // 自治体
        url = ""             // URL
        memo = ""            // メモ
        time = ""
    }
    
    var body: some View {
        VStack{
            
            // MARK: - Header
            HeaderView(headerTitle: "更新")
            
            // MARK: - Input
            InputFuluLogView(productName: $productName, amount: $amount, municipality: $municipality, url: $url, memo: $memo,time: $time)
            
            // MARK: - UpdateBtn
            Button(action: {
                withAnimation(.linear(duration: 0.3)){
                
                    if isFavorite == false {
                        // MARK: - FuluLog
                        realmDataBase.updateRecord(id: item.id, productName: productName, amount: amount, municipality: municipality, url: url,memo: memo, request: item.request,time:displayDate.getConvertStringDate(time))
                        
                    }else{
                        // MARK: - Favorite
                        realmDataBase.favorite_updateRecord(id: item.id, productName: productName, amount: amount, municipality: municipality, url: url,memo: memo, request: item.request,time:displayDate.getConvertStringDate(time))
                    }
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
        .alert(Text("更新しました。"),isPresented: $isAlert){
            Button(action: {
                resetInputData()
                isModal = false
            }, label: {
                Text("OK")
            })
        } message: {
            Text("")
        }
    }
}


