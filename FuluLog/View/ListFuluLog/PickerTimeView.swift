//
//  PickerTimeView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/17.
//

import SwiftUI
import RealmSwift

// ListFuluLogView > PickerTimeView
struct PickerTimeView: View {
    
    @Binding var selectTime:String
    @ObservedObject private var realmViewModel = RealmDataBaseViewModel.shared
    
    private var timeArray: [String] {
        var array:[String] = ["all"]
        for item in realmViewModel.records {
            array.append(String(item.timeString.prefix(4)))
        }
        let timeSet = Set(array) // 重複値を除去
        return Array(timeSet).sorted().reversed()
    }
    
    var body: some View {
        Image(systemName: "calendar")
            .foregroundColor(.orange)
        
        Picker(selection: $selectTime, content: {
            ForEach(timeArray,id:\.self) { item in
                Text(item)
            }
            
        }, label: { }
        ).padding(.trailing)
            .frame(minWidth: 100)
    }
}

struct PickerTimeView_Previews: PreviewProvider {
    static var previews: some View {
        PickerTimeView(selectTime: Binding.constant("all"))
    }
}
