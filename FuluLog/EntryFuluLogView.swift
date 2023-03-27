//
//  EntryFuluLogView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/10.
//

import SwiftUI

struct EntryFuluLogView: View {
    
    // MARK: - ViewModels
    private let validation = ValidationViewModel()
    private let realmDataBase = RealmDataBaseViewModel()
    private let userDefaults = UserDefaultsViewModel()
    
    // MARK: - Models
//    @EnvironmentObject var allFulu:AllFuluLog
//    var fileController = FileController()
    
    
    // MARK: - TextField
    @State var productName:String = ""     // 商品名
    @State var amount:Int = -1             // 金額情報
    @State var municipality:String = ""    // 自治体
    @State var url:String = ""             // URL
    @State var memo:String = ""            // メモ
    @State var time:String = {             // 初期値に現在の日付の文字列 yyyy/MM/dd
        let str = DisplayDateViewModel().getDateDisplayFormatString(Date())
        return str
    }()
    
    // MARK: - View
    @State var isAlert:Bool = false
    @State var isLimitAlert:Bool = false // 上限に達した場合のアラート
    
    // MARK: - Method
    func limitCountData() -> Bool{
        if realmDataBase.count < userDefaults.getDonationLimitKey() {
            
            // 現在の要素数 < 上限数
            isLimitAlert = false
            return true
        }else{

            // 現在の要素数 = 上限数
            isLimitAlert = true
            return false
        }
    }
    
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
    
    private func deleteInput(){
        productName = ""     // 商品名
        amount = -1           // 金額情報
        municipality = ""    // 自治体
        url = ""             // URL
        memo = ""            // メモ
        time = ""
    }
    
    
    var body: some View {
        VStack(spacing:0){
            
            // MARK: - Header
            HeaderView(headerTitle: "ふるログ")
            
            // MARK: - Input
            InputFuluLogView(productName: $productName, amount: $amount, municipality: $municipality, url: $url, memo: $memo,time: $time)
                .background(Color("FoundationColor"))
            
            // MARK: - EntryBtn
            Button(action: {
                if limitCountData(){
                    
                    // -- JSON
//                    let data = FuluLog(productName: productName, amount: amount, municipality: municipality, url: url,memo: memo,time: time)
//                    fileController.saveJson(data)
//
//                    allFulu.setAllData()
//                    allFulu.createTimeArray() // ソート用に登録されている全年数を保持した配列を生成
                    // -- JSON
                    
                    // -- Realm
                    realmDataBase.createRecord(productName: productName, amount: amount, municipality: municipality, url: url,memo: memo,time: DisplayDateViewModel().getConvertStringDate(time))
                    // -- Realm
                    
                    
                    deleteInput()
                }
                isAlert = true
            }, label: {
                Text("登録")
            })
            .padding(12) // ボタンパディング用
            .disabled(validatuonInput())
            .background(validatuonInput() ? Color(red: 0.8, green: 0.8, blue: 0.8) : Color("SubColor") )
            .foregroundColor(validatuonInput() ? Color.black : Color("ThemaColor"))
            .cornerRadius(5)
            .padding()
            // MARK: - EntryBtn
         
            
            Spacer()
            
        }
            .background(Color.white)
        .alert(Text(isLimitAlert ? "上限に達しました" : "寄付情報を保存しました。"),
               isPresented: $isAlert,
               actions: {
            Button(action: {}, label: {
                Text("OK")
            })
        }, message: {
            Text(isLimitAlert ? "広告を視聴すると\n保存容量を増やすことができます。" : "")
        })

           
        
    }
}

struct EntryFuluLogView_Previews: PreviewProvider {
    static var previews: some View {
        EntryFuluLogView()
    }
}
