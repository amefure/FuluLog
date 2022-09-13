//
//  UpdateFuluView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/11.
//

import SwiftUI

struct UpdateFuluLogView: View {
    
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
    @State var isAlert:Bool = false     // 新規登録/更新処理を実行したアラート
    
    // MARK: - Receive
    var item:FuluLog
    @Binding var isModal:Bool
    // 親メソッドを受けとる
    var parentUpdateItemFunction: (_ data:FuluLog) -> Void
    
    // MARK: - Method
    func validatuonInput() -> Bool{
        if productName !=  "" && amount != -1 && municipality != "" && url != ""  {
            if validationUrl(url) {
                return false // ←disable
            }
            return true
        }
        return true
    }
    
    func deleteInput(){
        productName = ""     // 商品名
        amount = -1          // 金額情報
        municipality = ""    // 自治体
        url = ""             // URL
        memo = ""            // メモ
    }
    
    func validationUrl (_ urlStr: String) -> Bool {
        if let url = NSURL(string: urlStr) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
    }
    
    
    var body: some View {
        VStack{
            // MARK: - Input
            InputFuluLogView(productName: $productName, amount: $amount, municipality: $municipality, url: $url, memo: $memo)
            
            // MARK: - UpdateBtn
            Button(action: {
                withAnimation(.linear(duration: 0.3)){
                    let data = FuluLog(productName: productName, amount: amount, municipality: municipality, url: url,memo: memo)
                    allFulu.updateData(data,item.id)
                    fileController.updateJson(allFulu.allData) // JSONファイルを更新
                    allFulu.setAllData()
                    parentUpdateItemFunction(data)
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
        }
        .alert(isPresented: $isAlert){
            Alert(title:Text("更新しました。"),
                  message: Text(""),
                  dismissButton: .default(Text("OK"),
                                          action: {
                deleteInput()
                isModal = false
            }))
        }
        
    }
}

struct UpdateFuluView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateFuluLogView(item: FuluLog(productName: "", amount: 0, municipality: "", url: ""),isModal:Binding.constant(true), parentUpdateItemFunction:{ data in })
    }
}
