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

    
    // MARK: - View
    @State var isShowTextField:Bool = false    // 上限入力Field
    @State var limitAmount:String = ""         // 上限金額
    
    
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
            VStack(spacing:0){
                
                // MARK: - Header
                HeaderView(headerTitle: "設定")
                
                Spacer()
                
                // MARK: - 寄付金上限金額
                Section(content: {
                    DonationLimitView().environmentObject(allFulu)
                }, header: {
                    HStack{
                        Text("今年の寄付金上限金額設定").font(.system(size: 20)).fontWeight(.bold).foregroundColor(.gray).padding()
                        Spacer()
                    }
                })
                
                Spacer()
                
                // MARK: - List
                Section(content: {
                    List{
                        // 1:容量追加
                        RewardBtnView()
                        // 1:容量追加
                        
                        
                        // 2:レビューページ
                        Link(destination:URL.init(string: "https://apps.apple.com/jp/app/%E3%81%B5%E3%82%8B%E3%83%AD%E3%82%B0/id1644963031?action=write-review")!, label: {
                            HStack{
                                Image(systemName:"hand.thumbsup").frame(width: 30).frame(width: 30).foregroundColor(.orange)
                                Text("アプリをレビューする")
                            }
                        })
                        // 2:レビューページ
                        
                        
                        // 3:シェアボタン
                        Button(action: {
                            shareApp(shareText: "寄付したふるさと納税を管理できるアプリ「ふるログ」を使ってみてね♪", shareLink: "https://apps.apple.com/jp/app/%E3%81%B5%E3%82%8B%E3%83%AD%E3%82%B0/id1644963031")
                        }) {
                            HStack{
                                Image(systemName:"star.bubble").frame(width: 30).frame(width: 30).foregroundColor(.orange)
                                Text("ふるログをオススメする")
                            }
                        }
                        // 3:シェアボタン
                        
                        
                        // 4:利用規約とプライバシーポリシー
                        Link(destination:URL.init(string: "https://tech.amefure.com/app-terms-of-service")!, label: {
                            HStack{
                                Image(systemName:"note.text").frame(width: 30).frame(width: 30).foregroundColor(.orange)
                                Text("利用規約とプライバシーポリシー")
                                Image(systemName:"link").font(.caption)
                            }
                        })
                        // 4:プライバシーポリシー
                        
                    }.listStyle(GroupedListStyle()) // Listのスタイルを横に広げる
                }, header: {
                    HStack{
                        Text("設定").font(.system(size: 20)).fontWeight(.bold).foregroundColor(.gray).padding()
                        Spacer()
                    }
                })
                
                // MARK: - AdMob iPhoneSEサイズが非表示
                if UIScreen.main.bounds.height >= 844 {
                    AdMobBannerView().frame(height:100).padding(.bottom)
                }
                
            }.foregroundColor(colorScheme == .dark ? .white : .black) // VStack
        .navigationBarHidden(true)
        }.navigationViewStyle(.stack) // NavigationView
        
        
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
