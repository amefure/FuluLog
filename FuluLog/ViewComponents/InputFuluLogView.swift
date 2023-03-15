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
    @State var amountString:String = ""   // 金額情報 String
    @Binding var amount:Int               // 金額情報
    @Binding var municipality:String      // 自治体
    @Binding var url:String               // URL
    @Binding var memo:String              // メモ
    @Binding var time:String              // 時間 String
    @State var selectedTime:Date = Date() // 時間
    
    @State var isShowDate:Bool = false
    
    // MARK: - Method
    func numChange (_ str:String) -> Int{
        guard let num = Int(str) else {
            return -1 // 文字列の場合
        }
        return num    // 数値の場合
    }
    
    var df:DateFormatter{
        let df = DateFormatter()
        df.calendar = Calendar(identifier: .gregorian)
        df.locale = Locale(identifier: "ja_JP")
        df.timeZone = TimeZone(identifier: "Asia/Tokyo")
        df.dateStyle = .short
        df.timeStyle = .none
        return df
    }
    
    var deviceWidth:Double {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return UIScreen.main.bounds.width/1.5
        }else{
            return UIScreen.main.bounds.width
        }
    }
    
    
    var body: some View {
        ScrollView{
            
            
            VStack{
                // MARK: - productName
                Group{
                    Text("商品名")
                        .frame(width: deviceWidth, height: 30)
                        .background(Color("SubColor"))
                        .foregroundColor(Color("ThemaColor"))
                    TextField("北海道産ほたて 2kg", text: $productName)
                        .frame(width: deviceWidth)
                }
                // MARK: - productName
                
                // MARK: - amount
                Group{
                    Text("寄付金額")
                        .frame(width: deviceWidth, height: 30)
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
                        .frame(width: deviceWidth)
                }
                // MARK: - amount
                
                // MARK: - municipality
                Group{
                    Text("自治体名").frame(width: deviceWidth, height: 30).background(Color("SubColor")).foregroundColor(Color("ThemaColor"))
                    TextField("北海道札幌市", text: $municipality)
                        .frame(width: deviceWidth)
                }
                // MARK: - municipality
                
                // MARK: - url
                Group{
                    Text("購入URL(※有効なURLを入力してください)").frame(width: deviceWidth, height: 30).background(Color("SubColor")).foregroundColor(Color("ThemaColor"))
                    TextField("https://XXX.com/post12", text: $url)
                        .frame(width: deviceWidth)
                }
                // MARK: - url
                
                // MARK: - memo
                Group{
                    Text("Memo").frame(width: deviceWidth, height: 30).background(Color("SubColor")).foregroundColor(Color("ThemaColor"))
                    TextEditor(text: $memo).frame(minHeight:UIScreen.main.bounds.height > 667 ? 150 : 60)
                        .frame(width: deviceWidth)
                }
                // MARK: - memo
                
                // MARK: - time
                Group{
                    if isShowDate{
                        DatePicker("Date", selection: $selectedTime, displayedComponents: .date)
                            .environment(\.locale, Locale(identifier: "ja_JP"))
                            .labelsHidden()
                            .padding(5)
                            .frame(width:110)
                    }
                    Button(action: {
                        isShowDate.toggle()
                    }, label: {
                        
                        VStack{
                            if isShowDate{
                                Text("決定")
                            }else{
                                HStack{
                                    Image(systemName: "calendar")
                                    Text("\(time)")
                                }
                            }
                        }.padding(5)
                    })
                    
                }.accentColor(.orange)
                // MARK: - time
                
            }
        }
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .onChange(of: selectedTime){ newValue in
            // yyyy/mm/dd 形式に変更して格納
            time = df.string(from: selectedTime)
        }
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
        .onChange(of: time){ newValue in
            // newValueには更新View初期値 or データリセット
            
            let df = DateFormatter()
            df.dateFormat = "yyyy/MM/dd"
            df.calendar = Calendar(identifier: .gregorian)
            df.locale = Locale(identifier: "ja_JP")
            df.timeZone = TimeZone(identifier: "Asia/Tokyo")
            df.dateStyle = .short
            df.timeStyle = .none
            
            if newValue == ""{
                // リセット時は当日の日付を格納
                selectedTime = Date()
            }else{
                // 更新View時はアイテムに登録されている日付をキャスト
                let itemTime = newValue
                let date = df.date(from: itemTime)!
                selectedTime = date
            }
        }
    }
}

struct InputFuluView_Previews: PreviewProvider {
    static var previews: some View {
        InputFuluLogView(productName: Binding.constant(""), amount: Binding.constant(0), municipality: Binding.constant(""), url: Binding.constant(""), memo: Binding.constant(""),time: Binding.constant(""))
    }
}
