//
//  InputFuluView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/10.
//

import SwiftUI
import UIKit

struct InputFuluLogView: View {
    
    // MARK: - FocusState
    @FocusState var isActive:Bool   // キーボードフォーカス
    
    // MARK: - TextField & Receive
    @Binding var productName:String       // 商品名
    @State var amountString:String = ""   // 金額情報
    @Binding var amount:Int               // 金額情報
    @Binding var municipality:String      // 自治体
    @Binding var url:String               // URL
    @Binding var memo:String              // メモ
    
    // MARK: - Method
    func numChange (_ str:String) -> Int{
        guard let num = Int(str) else {
            return -1 // 文字列の場合
        }
        return num    // 数値の場合
    }
    
    
    
    var body: some View {
     
        VStack{
            // MARK: - productName
            Text("商品名")
                .frame(width: UIScreen.main.bounds.width, height: 30)
                .background(Color("SubColor"))
                .foregroundColor(Color("ThemaColor"))
            TextField("北海道産ほたて 2kg", text: $productName)
            // MARK: - productName
            
            // MARK: - amount
            Text("寄付金額")
                .frame(width: UIScreen.main.bounds.width, height: 30)
                .background(Color("SubColor"))
                .foregroundColor(Color("ThemaColor"))
            TextField("20000", text: $amountString)
                .keyboardType(.numberPad)
                .focused($isActive)
                    .toolbar{
                    ToolbarItemGroup(placement: .keyboard, content: {
                        Spacer()
                        Button("閉じる"){
                            isActive = false
                        }
                    })
                    }
            // MARK: - amount
            
            // MARK: - municipality
            Text("自治体名").frame(width: UIScreen.main.bounds.width, height: 30).background(Color("SubColor")).foregroundColor(Color("ThemaColor"))
            TextField("北海道札幌市", text: $municipality)
            // MARK: - municipality
            
            // MARK: - url
            Text("購入URL(※有効なURLを入力してください)").frame(width: UIScreen.main.bounds.width, height: 30).background(Color("SubColor")).foregroundColor(Color("ThemaColor"))
            TextField("https://XXX.com/post12", text: $url)
            // MARK: - url
            
            // MARK: - memo
            Text("Memo").frame(width: UIScreen.main.bounds.width, height: 30).background(Color("SubColor")).foregroundColor(Color("ThemaColor"))
            TextEditor(text: $memo).frame(minHeight:UIScreen.main.bounds.height > 667 ? 100 : 60)
            // MARK: - memo
            
        }
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .onChange(of: amountString){ newValue in
            // 入力時数値変換用
            amount = numChange(newValue)
        }
        .onChange(of: amount){ newValue in
            // データリセット & 更新View初期値格納用
            if amount != -1{
                amountString = String(newValue)
            }else{
                amountString = ""
            }
        }
    }
}

struct InputFuluView_Previews: PreviewProvider {
    static var previews: some View {
        InputFuluLogView(productName: Binding.constant(""), amount: Binding.constant(0), municipality: Binding.constant(""), url: Binding.constant(""), memo: Binding.constant(""))
    }
}
