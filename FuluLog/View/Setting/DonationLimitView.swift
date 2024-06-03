//
//  DonationLimitView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/17.
//

import SwiftUI
import RealmSwift

// SettingView.swift > DonationLimitView

struct DonationLimitView: View {
    
    // MARK: - Utility
    private let displayDate = DateFormatUtility()
    
    // MARK: - ViewModels
    @ObservedObject private var realmViewModel = RealmDataBaseViewModel.shared
    // 当月の寄付金上限金額データ
    @State public var currentUserDonationInfo: UserDonationInfoRecord?
    
    // MARK: - View
    @State private var isShowTextField:Bool = false    // リワード広告視聴回数制限アラート
    @State private var limitAmount = ""         // 上限金額
    
    private func setLimitAmount() {
        if let userDonationInfo = realmViewModel.userDonationInfoList.first(where: {$0.year == displayDate.nowYearString()}) {
            currentUserDonationInfo = userDonationInfo
            limitAmount = String(userDonationInfo.limitAmount)
        }
    }
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                if isShowTextField {
                    TextField("40000", text: $limitAmount)
                        .keyboardType(.numberPad)
                        .frame(height: 70)
                        .textFieldStyle(.roundedBorder)
                } else {
                    if let userDonationInfo = currentUserDonationInfo {
                        
                        HStack {
                            Spacer()
                            Text("\(userDonationInfo.limitAmount)")
                                .font(.system(size: 35))
                                .foregroundStyle(.orange)
                                .lineLimit(1)
                            Text("円")
                                .font(.system(size: 20))
                                .offset(x: 0, y: 5)
                        }.frame(height:70)
                        
                    } else {
                        HStack{
                            Spacer()
                            Text("未設定")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundStyle(.orange)
                        }.frame(height:70)
                    }
                }
                
                
                Spacer()
                
                // 登録/更新ボタン
                Button {
                    // 編集状態なら登録/更新処理
                    if isShowTextField == true {
                        // 当月の情報が存在しないなら
                        if let userDonationInfo = currentUserDonationInfo {
                            // 更新処理
                            let id = userDonationInfo.id
                            realmViewModel.donation_updateRecord(
                                id: id,
                                year: displayDate.nowYearString(),
                                limitAmount: Int(limitAmount) ?? 0
                            )
                        } else {
                            // 新規登録
                            realmViewModel.donation_createRecord(
                                year: displayDate.nowYearString(),
                                limitAmount: Int(limitAmount) ?? 0
                            )
                        }
                        setLimitAmount()
                    }
                    
                    isShowTextField.toggle()
                } label: {
                    if currentUserDonationInfo != nil {
                        Text(isShowTextField ? "更新" : "編集")
                    } else {
                        Text("登録")
                    }
                }.padding(5) // ボタンパディング用
                    .background(Asset.Colors.subColor.swiftUIColor)
                    .foregroundStyle(Asset.Colors.themaColor.swiftUIColor)
                    .cornerRadius(5)
                    .padding()
                
            }
            
            NavigationLink {
                ListDonationLimitHistory()
            } label: {
                HStack{
                    Spacer()
                    Text("寄付金上限履歴")
                    Image(systemName: "chevron.right")
                }.padding()
            }.foregroundStyle(.orange)
            
        }.padding()
            .background(Asset.Colors.baseColor.swiftUIColor)
            .onAppear {
                setLimitAmount()
            }
    }
}

struct DonationLimitView_Previews: PreviewProvider {
    static var previews: some View {
        DonationLimitView()
    }
}
