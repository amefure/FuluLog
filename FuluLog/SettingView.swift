//
//  SettingView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/10.
//

import SwiftUI

struct SettingView: View {
    
    // MARK: - Models
    @Environment(\.colorScheme) var colorScheme : ColorScheme
    @EnvironmentObject var allFulu:AllFuluLog
    var fileController = FileController()
    
    // MARK: - AdMob
    @ObservedObject var reward = Reward()
    
    // MARK: - Storage
    @AppStorage("LastAcquisitionDate") var lastAcquisitionDate = ""
    
    
    // MARK: - View
    @State var isAlertReward:Bool = false      // リワード広告視聴回数制限アラート
    @State var isShowTextField:Bool = false    // リワード広告視聴回数制限アラート
    @State var limitAmount:String = ""         // 上限金額
    
    
    // MARK: - Method
    func nowTime() -> String{
        let df = DateFormatter()
        df.calendar = Calendar(identifier: .gregorian)
        df.locale = Locale(identifier: "ja_JP")
        df.timeZone = TimeZone(identifier: "Asia/Tokyo")
        df.dateStyle = .short
        df.timeStyle = .none
        return df.string(from: Date())
    }
    
    // シェアボタン
    func shareApp(shareText: String, shareLink: String) {
        let items = [shareText, URL(string: shareLink)!] as [Any]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popPC = activityVC.popoverPresentationController {
                popPC.sourceView = activityVC.view
                popPC.barButtonItem = .none
                popPC.sourceRect = activityVC.accessibilityFrame
            }
        }
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let rootVC = windowScene?.windows.first?.rootViewController
        rootVC?.present(activityVC, animated: true,completion: {})
    }
    
    var body: some View {
        NavigationView{
            VStack{
                
                Section(content: {
                    DonationLimitView().environmentObject(allFulu)
                }, header: {
                    HStack{
                        Text("今年の寄付金上限金額設定").font(.system(size: 20)).fontWeight(.bold).foregroundColor(.gray).padding()
                        Spacer()
                    }
                })
                
                Spacer()
                
                Section(content: {
                    
                    
                    List{
                        // 1:容量追加
                        Button(action: {
                            // 1日1回までしか視聴できないようにする
                            if lastAcquisitionDate != nowTime() {
                                reward.showReward()          //  広告配信
                                fileController.addLimitTxt() // 報酬獲得
                                lastAcquisitionDate = nowTime() // 最終視聴日を格納
                                
                            }else{
                                isAlertReward = true
                            }
                        }) {
                            HStack{
                                Image(systemName:"bag.badge.plus").frame(width: 30).foregroundColor(.orange)
                                Text("広告を見て保存容量を追加する")
                                Spacer()
                                Text("容量:\(fileController.loadLimitTxt())")
                            }
                        }
                        .onAppear() {
                            reward.loadReward()
                        }
                        .disabled(!reward.rewardLoaded)
                        .alert(isPresented: $isAlertReward){
                            Alert(title:Text("お知らせ"),
                                  message: Text("広告を視聴できるのは1日に1回までです"),
                                  dismissButton: .default(Text("OK"),
                                                          action: {}))
                        }
                        // 1:容量追加
                        
                        
                        // 2:利用規約とプライバシーポリシー
                        Link(destination:URL.init(string: "https://ame.hp.peraichi.com/")!, label: {
                            HStack{
                                Image(systemName:"note.text").frame(width: 30).frame(width: 30).foregroundColor(.orange)
                                Text("利用規約とプライバシーポリシー")
                                Image(systemName:"link").font(.caption)
                            }
                        })
                        // 2:プライバシーポリシー
                        
                        
                        // 3:シェアボタン
                        Button(action: {
                            shareApp(shareText: "寄付したふるさと納税を管理できるアプリ「ふるログ」を使ってみてね♪", shareLink: "https://apps.apple.com/jp/app/mapping/id1639823172")
                        }) {
                            HStack{
                                Image(systemName:"star.bubble").frame(width: 30).frame(width: 30).foregroundColor(.orange)
                                Text("ふるログをオススメする")
                            }
                        }
                        // 3:シェアボタン
                    }.listStyle(GroupedListStyle()) // Listのスタイルを横に広げる
                }, header: {
                    HStack{
                        Text("設定").font(.system(size: 20)).fontWeight(.bold).foregroundColor(.gray).padding()
                        Spacer()
                    }
                })
                
                if UIScreen.main.bounds.height >= 844 {
                    AdMobBannerView().frame(height:100).padding(.bottom)
                }
                
            }.foregroundColor(colorScheme == .dark ? .white : .black) // VStack
            
        }.navigationViewStyle(.stack) // NavigationView
         .navigationBarHidden(true)
        
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
