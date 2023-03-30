//
//  InputAmountView.swift
//  FuluLog
//
//  Created by t&a on 2023/03/30.
//

import SwiftUI

struct InputAmountView: View {
    // MARK: - ViewModels
    private let deviceSize = DeviceSizeViewModel()
    
    // MARK: - TextField & Receive
    @Binding var amount:Int               // 金額情報
    @State var amountString:String = ""   // 金額情報 String
    
    // MARK: - Method
    private func convertNumber (_ str:String) -> Int{
        guard let num = Int(str) else {
            return -1 // 文字列の場合
        }
        return num    // 数値の場合
    }
    
    var body: some View {
        Group{
            Text("寄付金額")
                .inputItemBackView()
            TextField("20000", text: $amountString)
                .keyboardType(.numberPad)
                .frame(width: deviceSize.flexWidth)
        }
        .onChange(of: amountString){ newValue in
            // 入力時数値変換用
            amount = convertNumber(newValue)
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


