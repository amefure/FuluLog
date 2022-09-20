//
//  EntryFavoriteFuluLogView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/18.
//

import SwiftUI

struct EntryFavoriteFuluLogView: View {
    
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
    @Binding var isModal:Bool
    
    // MARK: - Method
    
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
        
            VStack{
                // MARK: - Input
                InputFuluLogView(productName: $productName, amount: $amount, municipality: $municipality, url: $url, memo: $memo,time: $time)
                
                // MARK: - UpdateBtn
                Button(action: {
                    withAnimation(.linear(duration: 0.3)){
                        let data = FuluLog(productName: productName, amount: amount, municipality: municipality, url: url,memo: memo,time: time)
                        fileController.saveFavoriteJson(data)
                        allFulu.setAllFavoriteData()
                        deleteInput()
                        isAlert = true
                    }
                }, label: {
                    Text("登録")
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
            .alert(isPresented: $isAlert){
                Alert(title:Text("お気に入りに登録しました。"),
                      message: Text(""),
                      dismissButton: .default(Text("OK"),
                                              action: {
                    deleteInput()
                    isModal = false
                }))
            }
            
        }
    }
    
struct EntryFavoriteFuluLogView_Previews: PreviewProvider {
    static var previews: some View {
        EntryFavoriteFuluLogView(isModal: Binding.constant(false))
    }
}
