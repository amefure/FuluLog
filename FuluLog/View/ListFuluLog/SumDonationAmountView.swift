//
//  SumDonationAmountView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/17.
//

import SwiftUI
import RealmSwift

// ListFuluLogView > SumDonationAmount

struct SumDonationAmountView: View {
    // MARK: - ViewModels
    private let displayDate = DateFormatUtility()
    
    @Binding var selectTime:String
    
    @ObservedResults(FuluLogRecord.self) var allFuleRelam
    @ObservedResults(UserDonationInfoRecord.self) var allUserDonationInfoRecord

    // MARK: - Method
    private func currentSelectionYear() -> String {
        // 2022 形式で年を返す
        if selectTime == "all"{
            return displayDate.nowYearString()
        } else {
            return selectTime
        }
    }
    
    private func CheckOverAmount() -> Bool {
        if let index = allUserDonationInfoRecord.firstIndex(where: { $0.year == currentSelectionYear()}) {
            if sumYearAmount(String(currentSelectionYear())) > allUserDonationInfoRecord[index].limitAmount {
                return true // Over
            }
        }
        return false
    }
    
    private func sumYearAmount(_ year:String) -> Int {
        var sum = 0

        let filterData = allFuleRelam.filter({$0.timeString.prefix(4) == year })
        for data in filterData {
            sum += data.amount
        }
        return sum
    }
    
    var body: some View {
        
        Spacer()
        
        VStack {
            Text("\(currentSelectionYear())年：合計寄付金額")
                .foregroundStyle(Asset.Colors.exText.swiftUIColor)
                .font(.system(size: 12))
            HStack{
                Text("\(sumYearAmount(String(currentSelectionYear())))")
                    .foregroundColor(CheckOverAmount() ? .red : .orange)
                    .lineLimit(1)
                Text("円")
                    .font(.system(size: 12))
            }
        }
        if let index = allUserDonationInfoRecord.firstIndex(where: {$0.year == currentSelectionYear()}){
            Text("/")
                .offset(x: 0, y: 5)
            VStack {
                Text("上限寄付金額")
                    .foregroundStyle(Asset.Colors.exText.swiftUIColor)
                    .font(.system(size: 12))
                HStack {
                    Text("\(allUserDonationInfoRecord[index].limitAmount)")
                        .foregroundColor(.orange)
                        .lineLimit(1)
                    Text("円")
                        .font(.system(size: 10))
                        .foregroundStyle(Asset.Colors.exText.swiftUIColor)
                }
            }
            Spacer()
        } // if
    }
}

struct SumDonationAmountView_Previews: PreviewProvider {
    static var previews: some View {
        SumDonationAmountView(selectTime: Binding.constant(""))
    }
}
