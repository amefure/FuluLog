//
//  PickerTimeView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/17.
//

import SwiftUI

// ListFuluLogView > PickerTimeView
struct PickerTimeView: View {
    @EnvironmentObject var allFulu:AllFuluLog
    @Binding var selectTime:String
    var body: some View {
        Image(systemName: "calendar").foregroundColor(.orange)
        
        Picker(selection: $selectTime, content: {
            ForEach(allFulu.timeArray,id:\.self) { item in
                Text(item)
            }
            
        }, label: {
        }).padding(.trailing)
            .frame(minWidth: 100)
    }
}

struct PickerTimeView_Previews: PreviewProvider {
    static var previews: some View {
        PickerTimeView(selectTime: Binding.constant("all"))
    }
}
