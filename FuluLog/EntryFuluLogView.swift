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
    
    // MARK: - View
    @State var isAlert:Bool = false
    @State var isLimitAlert:Bool = false // 上限に達した場合のアラート
    
    // MARK: - Method
    func limitCountData() -> Bool{
        if allFulu.countAllData() < fileController.loadLimitTxt() {
            // 現在の要素数 < 上限数
            return true
        }else{
            // 上限に達した場合
            isLimitAlert = true
            // 現在の要素数 = 上限数
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
        VStack{
            
            // MARK: - Header
            HeaderView(headerTitle: "ふるログ")
            
            Spacer()
            
            // MARK: - Input
            
            InputFuluLogView(productName: $productName, amount: $amount, municipality: $municipality, url: $url, memo: $memo)
            
            // MARK: - EntryBtn
            Button(action: {
                if limitCountData(){
                    let data = FuluLog(productName: productName, amount: amount, municipality: municipality, url: url,memo: memo)
                    fileController.saveJson(data)
                    allFulu.setAllData()
                    allFulu.createTimeArray()
                    deleteInput()
                    isAlert = true
                }else{
                    isLimitAlert = true
                }
            }, label: {
                Text("登録")
            })
            .padding() // ボタンパディング用
            .disabled(validatuonInput())
            .background(validatuonInput() ? Color(red: 0.8, green: 0.8, blue: 0.8) : Color("SubColor") )
            .foregroundColor(validatuonInput() ? Color.black : Color("ThemaColor"))
            .cornerRadius(5)
            .padding(.bottom) // 下部余白用
            // MARK: - EntryBtn
            
            Spacer()
            
        }.background(Color("FoundationColor"))
            .alert(isPresented: $isAlert){
                Alert(title:Text("保存しました。"),
                      message: Text(""),
                      dismissButton: .default(Text("OK"),
                                              action: {
                    deleteInput()
                }))
            }
            .alert(isPresented: $isLimitAlert){
                Alert(title:Text("上限に達しました"),
                      message: Text("広告を視聴すると\n保存容量を増やすことができます。"),
                      dismissButton: .default(Text("OK")))
            }
        
    }
}

struct EntryFuluLogView_Previews: PreviewProvider {
    static var previews: some View {
        EntryFuluLogView()
    }
}
