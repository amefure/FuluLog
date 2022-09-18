//
//  DonationLimitView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/17.
//

import SwiftUI


// SettingView.swift > DonationLimitView

struct DonationLimitView: View {
    // MARK: - Models
    @EnvironmentObject var allFulu:AllFuluLog
    var fileController = FileController()
    
    // MARK: - View
    @State var isShowTextField:Bool = false    // リワード広告視聴回数制限アラート
    @State var limitAmount:String = ""         // 上限金額
    
    
    // MARK: - Method
    func nowTimePrefix() -> String{
        let df = DateFormatter()
        df.calendar = Calendar(identifier: .gregorian)
        df.locale = Locale(identifier: "ja_JP")
        df.timeZone = TimeZone(identifier: "Asia/Tokyo")
        df.dateStyle = .short
        df.timeStyle = .none
        let timeStr = df.string(from: Date()).prefix(4)
        return String(timeStr) // 2022 形式で年を返す
    }
    
    var body: some View {
        
        VStack{
            
            HStack{
                // MARK: - Display&Input
                if isShowTextField {
                    // MARK: - Input
                    TextField("40000", text: $limitAmount).keyboardType(.numberPad).frame(height:70).textFieldStyle(.roundedBorder)
                }else{
                    // MARK: - Display
                    if let index = allFulu.donationLimit.firstIndex(where: {$0.year == nowTimePrefix()}){
                        HStack{
                            Spacer()
                            Text("\(allFulu.donationLimit[index].limitAmount)").font(.system(size: 35)).foregroundColor(.orange).lineLimit(1)
                            Text("円").font(.system(size: 20)).offset(x: 0, y: 5)
                        }.frame(height:70)
                    }else{
                        HStack{
                            Spacer()
                            Text("未設定").font(.system(size: 20)).fontWeight(.bold).foregroundColor(.orange)
                        }.frame(height:70)
                    }
                }
                // MARK: - Display&Input
                
                Spacer()
                // MARK: - Btn
                Button(action: {
                    // 編集ON時かつ初回入力時のみ初期値登録
                    if isShowTextField == false && limitAmount == "" {
                        if let index = allFulu.donationLimit.firstIndex(where: {$0.year == nowTimePrefix()}){
                            limitAmount = String(allFulu.donationLimit[index].limitAmount)
                        }
                    }else{
                        let data = UserDonationInfo(year: String(nowTimePrefix()), limitAmount: Int(limitAmount) ?? 0)
                        allFulu.updateDonationLimit(data,String(nowTimePrefix())) // Models側で処理
                        allFulu.setAllDonationLimit()
                    }
                    isShowTextField.toggle()
                }, label: {
                    if allFulu.donationLimit.firstIndex(where: {$0.year == nowTimePrefix()}) != nil{
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
                ListDonationLimitHistory().environmentObject(allFulu)
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
