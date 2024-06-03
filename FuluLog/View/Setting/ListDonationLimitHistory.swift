//
//  ListDonationLimitHistory.swift
//  FuluLog
//
//  Created by t&a on 2022/09/17.
//

import SwiftUI
import RealmSwift

// SettingView.swift > DonationLimitView > ListDonationLimitHistory

struct ListDonationLimitHistory: View {
    
    // MARK: - ViewModels
    @ObservedObject private var realmViewModel = RealmDataBaseViewModel.shared
    
    // MARK: - Method
    private func CheckOverAmount(_ year:String) -> Bool {
        if let userDonationInfo = realmViewModel.userDonationInfoList.first(where: {$0.year == year}) {
            return sumYearAmount(year) > userDonationInfo.limitAmount
        }
        return false
    }
    
    private func sumYearAmount(_ year:String) -> Int {
        var sum = 0
        let filterData = realmViewModel.records.filter({$0.timeString.prefix(4) == year })
        for data in filterData {
            sum += data.amount
        }
        return sum
    }
    
    // MARK: - Environment
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            
            // MARK: - Header
            HeaderView(
                headerTitle: "寄付金上限履歴",
                leadingIcon: "chevron.backward",
                leadingAction: { dismiss() }
            )
            
            List(realmViewModel.userDonationInfoList) { item in
                HStack{
                    Text("\(item.year)年")
                        .fontWeight(.bold)
                    Spacer()
                    HStack{
                        Text("\(sumYearAmount(item.year))")
                            .foregroundStyle(CheckOverAmount(item.year) ? .red : .orange)
                            .lineLimit(1)
                        Text("円")
                            .font(.system(size: 15))
                    }
                    Text("/")
                    HStack{
                        Text("\(item.limitAmount)")
                            .foregroundStyle(.orange)
                            .lineLimit(1)
                        Text("円")
                            .font(.system(size: 15))
                    }
                }.foregroundStyle(Asset.Colors.exText.swiftUIColor)
            }.scrollContentBackground(.hidden)
                .background(Asset.Colors.baseColor.swiftUIColor)
        }.background(Asset.Colors.baseColor.swiftUIColor)
            .navigationBarHidden(true)
    }
}

struct ListDonationLimitHistory_Previews: PreviewProvider {
    static var previews: some View {
        ListDonationLimitHistory()
    }
}
