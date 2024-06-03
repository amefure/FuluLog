//
//  DetailFuluView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/11.
//

import SwiftUI
import WidgetKit
import RealmSwift

struct DetailFuluLogView: View {
    
    private let userDefaults = UserDefaultsManager()
    private let displayDate = DateFormatUtility()
    
    // MARK: - ViewModels
    @ObservedObject private var realmViewModel = RealmDataBaseViewModel.shared
    
    // MARK: - Environment
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Receive
    public var item: FuluLogRecord
    
    
    // MARK: - View
    @State private var showUpdateView = false
    @State private var isAlertDelete = false
    @State var isOn = false// ワンストップ申請トグルボタン
    
    public var isFavorite: Bool // Favoriteからの呼出
    
    private func updateAppGroupandWidget() {
        let year = displayDate.nowYearString()
        let array = realmViewModel.records.filter({ $0.request == false && $0.timeString.contains(year) })
        userDefaults.setCountKey(count: array.count)
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    
    var body: some View {
        VStack {
            
            // MARK: - Header
            HeaderView(
                headerTitle: item.productName,
                leadingIcon: "chevron.backward",
                trailingIcon: "square.and.pencil",
                leadingAction: { dismiss() },
                trailingAction: { showUpdateView = true}
            )
            
            ScrollView {
                
                VStack(alignment: .leading) {
                    HStack{
                        // 商品名
                        Text(item.productName)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(Asset.Colors.exText.swiftUIColor)
                        
                        Spacer()
                        
                        // 共有ボタン
                        ShareBtnView(item: item)
                        
                        // お気に入り登録ボタン
                        if isFavorite == false {
                            EntryFavoriteBtnView(item: item)
                                .foregroundStyle(Asset.Colors.exText.swiftUIColor)
                        }
                        
                    }
                    
                    HStack{
                        Text("寄付した自治体：")
                        Text(item.municipality)
                        Spacer()
                        Text(item.timeString)
                    }.font(.system(size: 15))
                        .padding(.vertical, 5)
                        .foregroundStyle(Asset.Colors.exText.swiftUIColor)
                    
                    Rectangle()
                        .fill(Asset.Colors.exText.swiftUIColor)
                        .frame(height: 2)
                        .opacity(0.5)
                    
                }.padding(.vertical)
                
                
                HStack{
                    Text("\(item.amount)")
                        .font(.system(size: 35))
                        .foregroundColor(.orange)
                        .fontWeight(.bold)
                    Text("円")
                        .font(.system(size: 20))
                        .offset(x: 0, y: 5)
                        .foregroundStyle(Asset.Colors.exText.swiftUIColor)
                }.padding(.bottom)

                
                HStack {
                    Text(item.memo)
                        .foregroundStyle(Asset.Colors.exText.swiftUIColor)
                        .padding()
                    Spacer()
                }.frame(width: DeviceSizeUtility.deviceWidth - 30)
                    .background(Asset.Colors.baseColor.swiftUIColor)
                    .cornerRadius(5)
                
                
                HStack {
                    Text("購入URL：")
                        .foregroundStyle(Asset.Colors.exText.swiftUIColor)
                    if item.url.isEmpty {
                        Text("URL未登録")
                            .foregroundStyle(Asset.Colors.exText.swiftUIColor)
                    } else {
                        Link(destination: URL(string: item.url)!) {
                            HStack {
                                Text("\(item.url)")
                                    .lineLimit(1)
                                Image(systemName: "link")
                            }
                        }
                    }
                }.padding(.vertical)
                
                
                Spacer()
                
                if isFavorite == false {
                    Toggle(isOn: $isOn) {
                        HStack{
                            Text("ワンストップ申請発送")
                                .foregroundStyle(Asset.Colors.exText.swiftUIColor)
                            Image(systemName: isOn == true ? "checkmark.seal.fill" : "checkmark.seal")
                                .foregroundColor(isOn == true ? .orange : .gray)
                        }
                    }.padding(.vertical)
                        .padding(.trailing,10)
                        .tint(.orange)
                        .onChange(of: isOn) { newValue in
                            realmViewModel.updateRecord(
                                id: item.id,
                                productName: item.productName,
                                amount: item.amount,
                                municipality: item.municipality,
                                url: item.url,
                                request: isOn,
                                memo: item.memo,
                                time: item.time
                            )
                            // MARK: - ワンストップ申請の変更を反映する
                            updateAppGroupandWidget()
                        }
                }
                
                Spacer()
                
            
                Button(action: {
                    isAlertDelete = true
                }, label: {
                    HStack{
                        Image(systemName: isFavorite ? "star.slash" :"trash.fill")
                        Text(isFavorite ? "お気に入りを解除する" : "寄付情報を削除する")
                    }
                }).padding()
                    .background(Asset.Colors.subColor.swiftUIColor)
                    .foregroundColor(Asset.Colors.themaColor.swiftUIColor)
                    .cornerRadius(5)
                
            } // ScrollView
            
        }.background(Asset.Colors.baseColor.swiftUIColor)
            .textSelection(.enabled)
            .padding(.horizontal)
            .navigationBarHidden(true)
            .alert(Text(isFavorite ? "お気に入りを解除しますか？" : "寄付情報を削除しますか？"),isPresented: $isAlertDelete){
                Button(role: .destructive, action: {
                    withAnimation(.linear(duration: 0.3)){
                        if isFavorite == false {
                            realmViewModel.deleteRecord(id: item.id)
                        } else {
                            // MARK: - Favorite
                            realmViewModel.favorite_deleteRecord(id: item.id)
                        }
                        dismiss()
                    }
                }, label: {
                    Text(isFavorite ? "解除する" : "削除する")
                })
            } message: {
                
            }.sheet(isPresented: $showUpdateView, content: {
                UpdateFuluLogView(
                    item: item,
                    isModal: $showUpdateView,
                    isFavorite: isFavorite
                )
            })
    }
}
