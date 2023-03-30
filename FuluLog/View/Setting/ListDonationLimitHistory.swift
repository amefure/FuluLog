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
    private let realmDataBase = RealmDataBaseViewModel()
    
    @ObservedResults(FuluLogRecord.self) var allFuleRelam
    @ObservedResults(UserDonationInfoRecord.self) var allUserDonationInfoRecord
    
    private var realm_filteringAllFuludata:[UserDonationInfoRecord]{
       return allUserDonationInfoRecord.sorted(by: { $0.year < $1.year }).reversed()
    }
    
    // MARK: - Method
    private func CheckOverAmount(_ year:String) -> Bool{
        if let index = allUserDonationInfoRecord.firstIndex(where: {$0.year == year}){
            if sumYearAmount(year) > allUserDonationInfoRecord[index].limitAmount {
                return true // Over
            }
        }
        return false
    }
    
    private func sumYearAmount(_ year:String) -> Int{
        var sum = 0

        let filterData = allFuleRelam.filter({$0.timeString.prefix(4) == year })
        for data in filterData {
            sum += data.amount
        }
        return sum
    }
    
    var body: some View {
        VStack{
            
            List(realm_filteringAllFuludata){ item in
                HStack{
                    Text("\(item.year)年")
                        .fontWeight(.bold)
                    Spacer()
                    HStack{
                        Text("\(sumYearAmount(item.year))")
                            .foregroundColor(CheckOverAmount(item.year) ? .red : .orange)
                            .lineLimit(1)
                        Text("円")
                            .font(.system(size: 15))
                    }
                    Text("/")
                    HStack{
                        Text("\(item.limitAmount)")
                            .foregroundColor(.orange)
                            .lineLimit(1)
                        Text("円")
                            .font(.system(size: 15))
                    }
                }.foregroundColor(.gray)
            }
            
            AdMobBannerView().frame(height:150).padding(.bottom)
        }
    }
}

struct ListDonationLimitHistory_Previews: PreviewProvider {
    static var previews: some View {
        ListDonationLimitHistory()
    }
}
