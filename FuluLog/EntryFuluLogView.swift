//
//  EntryFuluLogView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/10.
//

import SwiftUI

struct EntryFuluLogView: View {
    
    // MARK: - Models
    @EnvironmentObject var allFulu:AllFuluLog
    var fileController = FileController()
    
    
    // MARK: - TextField
    @State var productName:String = ""     // 商品名
    @State var amount:Int = -1             // 金額情報
    @State var municipality:String = ""    // 自治体
    @State var url:String = ""             // URL
    @State var memo:String = ""            // メモ
    @State var time:String = {             // 初期値に現在の日付
        
        let df = DateFormatter()
        df.calendar = Calendar(identifier: .gregorian)
        df.locale = Locale(identifier: "ja_JP")
        df.timeZone = TimeZone(identifier: "Asia/Tokyo")
        df.dateStyle = .short
        df.timeStyle = .none
        return df.string(from: Date())

    }()
    
    // MARK: - View
    @State var isAlert:Bool = false
    @State var isLimitAlert:Bool = false // 上限に達した場合のアラート
    
    // MARK: - Method
    func limitCountData() -> Bool{
        if allFulu.countAllData() < fileController.loadLimitTxt() {
            
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
    func validatuonInput() -> Bool{
        // 必須入力は商品名と寄付金額のみ
        if productName !=  "" && amount != -1  {
            if url.isEmpty == false{ // 入力値があるならバリデーション
                if validationUrl(url) {
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
        amount = -1           // 金額情報
        municipality = ""    // 自治体
        url = ""             // URL
        memo = ""            // メモ
        time = ""
    }
    
    func validationUrl (_ urlStr: String) -> Bool {
        guard let encurl = urlStr.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            return false
        }
        if let url = NSURL(string: encurl) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
    }
    
    var body: some View {
        VStack(spacing:0){
            
            // MARK: - Header
            HeaderView(headerTitle: "ふるログ")
            
//            Spacer()
            
            // MARK: - Input
            InputFuluLogView(productName: $productName, amount: $amount, municipality: $municipality, url: $url, memo: $memo,time: $time)
                .background(Color("FoundationColor"))
            
            // MARK: - EntryBtn
            Button(action: {
                if limitCountData(){
                    let data = FuluLog(productName: productName, amount: amount, municipality: municipality, url: url,memo: memo,time: time)
                    fileController.saveJson(data)
                    allFulu.setAllData()
                    allFulu.createTimeArray()
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
//            .padding(.bottom) // 下部余白用
            .padding()
            // MARK: - EntryBtn
         
            
            Spacer()
            
        }
//        .background(Color("FoundationColor"))
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
