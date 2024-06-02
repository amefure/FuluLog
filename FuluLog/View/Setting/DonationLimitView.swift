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
    
    // MARK: - ViewModels
    private let realmDataBase = RealmDataBaseViewModel()
    private let userDefaults = UserDefaultsManager()
    private let displayDate = DateFormatUtility()
    
    @ObservedResults(UserDonationInfoRecord.self) var allUserDonationInfoRecord
    
    // MARK: - View
    @State var isShowTextField:Bool = false    // リワード広告視聴回数制限アラート
    @State var limitAmount:String = ""         // 上限金額
    
    private var realm_filteringAllFuludata:[UserDonationInfoRecord]{
        return allUserDonationInfoRecord.sorted(by: { $0.year < $1.year }).reversed()
    }
    
    
    var body: some View {
        
        VStack{
            
            HStack{
                // MARK: - Display&Input
                if isShowTextField {
                    // MARK: - Input
                    TextField("40000", text: $limitAmount)
                        .keyboardType(.numberPad)
                        .frame(height:70)
                        .textFieldStyle(.roundedBorder)
                }else{
                    // MARK: - Display
                    if let index = realm_filteringAllFuludata.firstIndex(where: {$0.year == displayDate.nowYearString()}){
                        
                        HStack{
                            Spacer()
                            Text("\(realm_filteringAllFuludata[index].limitAmount)")
                                .font(.system(size: 35))
                                .foregroundColor(.orange)
                                .lineLimit(1)
                            Text("円")
                                .font(.system(size: 20))
                                .offset(x: 0, y: 5)
                        }.frame(height:70)
                        
                    }else{
                        HStack{
                            Spacer()
                            Text("未設定")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(.orange)
                        }.frame(height:70)
                    }
                }
                // MARK: - Display&Input
                
                Spacer()
                // MARK: - Btn
                Button(action: {
                    if realm_filteringAllFuludata.firstIndex(where: {$0.year == displayDate.nowYearString()}) == nil{
                        realmDataBase.donation_createRecord(year:  displayDate.nowYearString(), limitAmount: Int(limitAmount) ?? 0)
                    }
                    // 編集ON時かつ初回入力時のみ初期値登録
                    if isShowTextField == false && limitAmount == "" {
                        if let index = realm_filteringAllFuludata.firstIndex(where: {$0.year == displayDate.nowYearString()}){
                            limitAmount = String(realm_filteringAllFuludata[index].limitAmount)
                        }
                    }else{
                        if let index = realm_filteringAllFuludata.firstIndex(where: {$0.year == displayDate.nowYearString()}){
                            let id = realm_filteringAllFuludata[index].id
                            realmDataBase.donation_updateRecord(id: id, year: displayDate.nowYearString(), limitAmount: Int(limitAmount)!)
                        }
                    }
                    isShowTextField.toggle()
                }, label: {
                    if realm_filteringAllFuludata.firstIndex(where: {$0.year == displayDate.nowYearString()}) != nil{
                        Text(isShowTextField ? "更新" : "編集")
                    }else{
                        Text("登録")
                    }
                })
                .padding(5) // ボタンパディング用
                .background(Color("SubColor") )
                .foregroundColor(Color("ThemaColor"))
                .cornerRadius(5)
                .padding()
                // MARK: - Btn
                
            }
            
            NavigationLink(destination: {
                ListDonationLimitHistory()
            }, label: {
                HStack{
                    Spacer()
                    Text("寄付金上限履歴")
                    Image(systemName: "chevron.right")
                }.padding()
            }).foregroundColor(.orange)
            
        }.padding().background(Color("BaseColor"))
    }
}

struct DonationLimitView_Previews: PreviewProvider {
    static var previews: some View {
        DonationLimitView()
    }
}
