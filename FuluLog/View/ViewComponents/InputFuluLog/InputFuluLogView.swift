//
//  InputFuluView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/10.
//

import SwiftUI
import UIKit

struct InputFuluLogView: View {
    
    // MARK: - ViewModels
    private let deviceSize = DeviceSizeViewModel()
    
    // MARK: - TextField & Receive
    @Binding var productName:String       // 商品名
    @Binding var amount:Int               // 金額情報
    @Binding var municipality:String      // 自治体
    @Binding var url:String               // URL
    @Binding var memo:String              // メモ
    @Binding var time:String              // 時間 String
    
    var body: some View {
        ScrollView{
            
            VStack{
                // MARK: - productName
                Group{
                    Text("商品名")
                        .inputItemBackView()
                    TextField("北海道産ほたて 2kg", text: $productName)
                        .frame(width: deviceSize.flexWidth)
                }
                // MARK: - productName
                
                // MARK: - amount
                InputAmountView(amount: $amount)
                // MARK: - amount
                
                // MARK: - municipality
                Group{
                    Text("自治体名")
                        .inputItemBackView()
                    TextField("北海道札幌市", text: $municipality)
                        .frame(width: deviceSize.flexWidth)
                }
                // MARK: - municipality
                
                // MARK: - url
                Group{
                    Text("購入URL(※有効なURLを入力してください)")
                        .inputItemBackView()
                    TextField("https://www.XXXX.com/post12", text: $url)
                        .frame(width: deviceSize.flexWidth)
                }
                // MARK: - url
                
                // MARK: - memo
                Group{
                    Text("Memo")
                        .inputItemBackView()
                    TextEditor(text: $memo)
                        .frame(minHeight:deviceSize.isSESize ? 60 : 150)
                        .frame(width: deviceSize.flexWidth)
                }
                // MARK: - memo
                
                // MARK: - time
                InputDatePickerView(time: $time)
                // MARK: - time
                
            }
        }
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}
