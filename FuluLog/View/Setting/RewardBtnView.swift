//
//  RewardBtnView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/21.
//

import SwiftUI

struct RewardBtnView: View {
    
    // MARK: - ViewModels
    private let userDefaults = UserDefaultsViewModel()
    private let displayDate = DisplayDateViewModel()
    @ObservedObject var reward = Reward() // MARK: - AdMob
    
    // MARK: - View
    @State var isAlertReward:Bool = false      // リワード広告視聴回数制限アラート
    
    var body: some View {
        Button(action: {
            // 1日1回までしか視聴できないようにする
            if userDefaults.getLastAcquisitionDateKey() != displayDate.nowFullDateString() {
                reward.showReward()          //  広告配信
                userDefaults.setLastAcquisitionDateKey(now: displayDate.nowFullDateString())
                userDefaults.addRecordLimitKey() // 報酬を付与
            }else{
                isAlertReward = true
            }
        }) {
            HStack{
                Image(systemName:"bag.badge.plus")
                    .frame(width: 30)
                    .foregroundColor(.orange)
                Text("広告を見て保存容量を追加する")
                Spacer()
                Text("容量:\(userDefaults.getRecordLimitKey())")
            }
        }
        .onAppear() {
            reward.loadReward()
        }
        .disabled(!reward.rewardLoaded)
        .alert(Text("お知らせ"),isPresented: $isAlertReward){
            Button(action: {
            }, label: {
                Text("OK")
            })
        } message: {
            Text("広告を視聴できるのは1日に1回までです")
        }
    }
}

struct RewardBtnView_Previews: PreviewProvider {
    static var previews: some View {
        RewardBtnView()
    }
}
