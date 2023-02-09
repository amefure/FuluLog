//
//  SumDonationAmountView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/17.
//

import SwiftUI

// ListFuluLogView > SumDonationAmount

struct SumDonationAmountView: View {
    
    @EnvironmentObject var allFulu:AllFuluLog
    
    @Binding var selectTime:String
    
    // MARK: - Method
    func nowTimePrefix() -> String{
        // 2022 形式で年を返す
        
        if selectTime == "all"{
            let df = DateFormatter()
            df.calendar = Calendar(identifier: .gregorian)
            df.locale = Locale(identifier: "ja_JP")
            df.timeZone = TimeZone(identifier: "Asia/Tokyo")
            df.dateStyle = .short
            df.timeStyle = .none
            let timeStr = df.string(from: Date()).prefix(4)
            return String(timeStr) // all なら当年
        }else{
            return selectTime
        }
    }
    
    func CheckOverAmount() -> Bool{
        if let index = allFulu.donationLimit.firstIndex(where: {$0.year == nowTimePrefix()}){
            if allFulu.sumYearAmount(String(nowTimePrefix())) > allFulu.donationLimit[index].limitAmount {
                return true // Over
            }
        }
        return false
    }
    
    
    var body: some View {
        
        Spacer()
        
        VStack{
            Text("\(nowTimePrefix())年：合計寄付金額").foregroundColor(.gray).font(.system(size: 12))
            HStack{
                Text("\(allFulu.sumYearAmount(String(nowTimePrefix())))").foregroundColor(CheckOverAmount() ? .red : .orange).lineLimit(1)
                Text("円").font(.system(size: 12))
            }
        }
        if let index = allFulu.donationLimit.firstIndex(where: {$0.year == nowTimePrefix()}){
            Text("/").offset(x: 0, y: 5)
            VStack{
                Text("上限寄付金額").foregroundColor(.gray).font(.system(size: 12))
                HStack{
                    Text("\(allFulu.donationLimit[index].limitAmount)").foregroundColor(.orange).lineLimit(1)
                    Text("円").font(.system(size: 10))
                }
            }
            
            Spacer()
        }
    }
}

struct SumDonationAmountView_Previews: PreviewProvider {
    static var previews: some View {
        SumDonationAmountView(selectTime: Binding.constant(""))
    }
}
