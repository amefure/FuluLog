//
//  InputDatePickerView.swift
//  FuluLog
//
//  Created by t&a on 2023/03/30.
//

import SwiftUI

struct InputDatePickerView: View {
    
    // MARK: - ViewModels
    private let deviceSize = DeviceSizeViewModel()
    private let displayDate = DisplayDateViewModel()
    
    @Binding var time:String              // 時間 String
    @State var selectedTime:Date = Date() // 時間

    
    var body: some View {
        Group{
            Text("日付")
                .inputItemBackView()
            DatePicker("Date", selection: $selectedTime, displayedComponents: .date)
                .environment(\.locale, Locale(identifier: "ja_JP"))
                .labelsHidden()
                .padding(5)
                .frame(width: deviceSize.flexWidth)
            
        }.accentColor(.orange)
            .onChange(of: selectedTime){ newValue in
                // yyyy/mm/dd 形式に変更して格納
                time = displayDate.getDateDisplayFormatString(newValue)
            }
            .onChange(of: time){ newValue in
                // newValueには更新View初期値 or データリセット
                
                if newValue == ""{
                    // リセット時は当日の日付を格納
                    selectedTime = Date()
                }else{
                    // 更新View時はアイテムに登録されている日付をキャスト
                    let date = displayDate.getConvertStringDate(newValue)
                    selectedTime = date
                }
            }
    }
}


