//
//  SettingView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/10.
//

import SwiftUI

struct SettingView: View {
    
    private let deviceSize = DeviceSizeUtility()
    
    // MARK: - View
    @State private var isShowTextField = false    // 上限入力Field
    @State private var limitAmount = ""         // 上限金額
    @Environment(\.colorScheme) var colorScheme : ColorScheme
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            // MARK: - Header
            HeaderView(headerTitle: "設定")
            
            Spacer()
            
            // MARK: - 寄付金上限金額
            Section(content: {
                DonationLimitView()
            }, header: {
                HStack{
                    Text("今年の寄付金上限金額設定")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                        .padding()
                    Spacer()
                }
            })
            
            Spacer()
            
            // MARK: - List
            Section(content: {
                List {
                    // 1:容量追加
                    RewardBtnView()
                    // 1:容量追加
                    
                    
                    // 2:レビューページ
                    if let url = URL(string: StaticUrls.APP_REVIEW_URL) {
                        Link(destination: url, label: {
                            HStack {
                                Image(systemName:"hand.thumbsup")
                                    .frame(width: 30)
                                    .foregroundStyle(.orange)
                                Text("アプリをレビューする")
                                    .foregroundStyle(Asset.Colors.exText.swiftUIColor)
                            }
                        })
                    }
                    
                    // 2:レビューページ
                    
                    
                    // 3:シェアボタン
                    Button(action: {
                        ShareContentUtility.share(text: "寄付したふるさと納税を管理できるアプリ「ふるログ」を使ってみてね♪", urlStr: StaticUrls.APP_URL)
                    }) {
                        HStack{
                            Image(systemName:"star.bubble")
                                .frame(width: 30)
                                .foregroundColor(.orange)
                            Text("ふるログをオススメする")
                                .foregroundStyle(Asset.Colors.exText.swiftUIColor)
                        }
                    }
                    // 3:シェアボタン
                    
                    
                    // 4:利用規約とプライバシーポリシー
                    if let url = URL(string: StaticUrls.APP_TERMS_OF_SERVICE_URL) {
                        Link(destination: url, label: {
                            HStack{
                                Image(systemName:"note.text")
                                    .frame(width: 30)
                                    .foregroundColor(.orange)
                                Text("利用規約とプライバシーポリシー")
                                    .foregroundStyle(Asset.Colors.exText.swiftUIColor)
                                Image(systemName:"link")
                                    .font(.caption)
                                    .foregroundStyle(Asset.Colors.exText.swiftUIColor)
                                
                            }
                        })
                    }
                    // 4:プライバシーポリシー
                    
                }.listStyle(GroupedListStyle()) // Listのスタイルを横に広げる
                    .scrollContentBackground(.hidden)
                        .background(Asset.Colors.baseColor.swiftUIColor)
            }, header: {
                HStack{
                    Text("設定")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                        .padding()
                    Spacer()
                }
            })
        }.navigationBarHidden(true)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
