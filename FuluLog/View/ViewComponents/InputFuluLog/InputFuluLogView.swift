//
//  InputFuluView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/10.
//

import SwiftUI
import UIKit

struct InputFuluLogView: View {
    
    
    // MARK: - TextField & Receive
    @Binding var productName:String       // 商品名
    @Binding var amount:Int               // 金額情報
    @State private var amountString = ""   // 金額情報 String
    @Binding var municipality:String      // 自治体
    @Binding var url:String               // URL
    @Binding var memo:String              // メモ
    @Binding var time:String              // 時間 String
    
    var body: some View {
        ScrollView {
            
            VStack {
                
                Group {
                    Text("商品名（＊）")
                        .inputItemBackView()
                    TextField("北海道産ほたて 2kg", text: $productName)
                        .frame(width: DeviceSizeUtility.flexWidth)
                }
                
                Group {
                    Text("寄付金額（＊）")
                        .inputItemBackView()
                    TextField("20000", text: $amountString)
                        .keyboardType(.numberPad)
                        .frame(width: DeviceSizeUtility.flexWidth)
                }
                .onChange(of: amountString) { newValue in
                    // 入力時数値変換用
                    amount = Int(newValue) ?? -1
                }.onChange(of: amount) { newValue in
                    // データリセット & 更新View初期値格納用
                    amountString = amount != -1 ? String(newValue) : ""
                }
                
                Group {
                    Text("自治体名")
                        .inputItemBackView()
                    TextField("北海道札幌市", text: $municipality)
                        .frame(width: DeviceSizeUtility.flexWidth)
                }
                
                Group {
                    Text("購入URL(※有効なURLを入力してください)")
                        .inputItemBackView()
                    TextField("URL", text: $url)
                        .frame(width: DeviceSizeUtility.flexWidth)    
                }
                
                Group {
                    Text("Memo")
                        .inputItemBackView()
                    TextEditor(text: $memo)
                        .frame(minHeight: DeviceSizeUtility.isSESize ? 60 : 150)
                        .frame(width: DeviceSizeUtility.flexWidth)
                        .background(.white)
                }
                
                InputDatePickerView(time: $time)
                
            }
        }.scrollContentBackground(.hidden)
            .background(Asset.Colors.baseColor.swiftUIColor)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}
