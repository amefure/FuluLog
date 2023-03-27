//
//  ListDonationLimitHistory.swift
//  FuluLog
//
//  Created by t&a on 2022/09/17.
//

import SwiftUI

// SettingView.swift > DonationLimitView > ListDonationLimitHistory

struct ListDonationLimitHistory: View {
    
    // MARK: - ViewModels
    private let realmDataBase = RealmDataBaseViewModel()
    
    @EnvironmentObject var allFulu:AllFuluLog
    
    
    func CheckOverAmount(_ year:String) -> Bool{
        if let index = allFulu.donationLimit.firstIndex(where: {$0.year == year}){
            if allFulu.sumYearAmount(year) > allFulu.donationLimit[index].limitAmount {
                return true // Over
            }
        }
        return false
    }
    
    var realm_filteringAllFuludata:[UserDonationInfoRecord]{
       return realmDataBase.allUserDonationInfoRecord.sorted(by: { $0.year < $1.year }).reversed()
    }
    
    var body: some View {
        VStack{
            
            List(realm_filteringAllFuludata){ item in
                HStack{
                    Text("\(item.year)年").fontWeight(.bold)
                    Spacer()
                    HStack{
                        Text("\(allFulu.sumYearAmount(item.year))").foregroundColor(CheckOverAmount(item.year) ? .red : .orange).lineLimit(1)
                        Text("円").font(.system(size: 15))
                    }
                    Text("/")
                    HStack{
                        Text("\(item.limitAmount)").foregroundColor(.orange).lineLimit(1)
                        Text("円").font(.system(size: 15))
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
