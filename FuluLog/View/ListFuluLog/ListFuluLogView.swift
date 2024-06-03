//
//  ListFuluLogView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/10.
//

import SwiftUI
import RealmSwift

struct ListFuluLogView: View {
    
    // MARK: - ViewModels
    @ObservedObject private var realmViewModel = RealmDataBaseViewModel.shared
    
    @State private var searchText = ""
    @State private var selectTime = "all"
    @State private var showEntryView = false
    
    // MARK: - List Filtering Data
    private var realm_filteringAllFuludata: [FuluLogRecord] {
        if searchText.isEmpty && selectTime == "all" {
            // フィルタリングなし
            return realmViewModel.records
        } else if searchText.isEmpty && selectTime != "all" {
            // 年数のみ
            return realmViewModel.records.filter({$0.timeString.contains(selectTime)})
        } else if searchText.isEmpty == false && selectTime != "all" {
            // 検索値＆年数
            return realmViewModel.records.filter({$0.productName.contains(searchText)}).filter({$0.timeString.contains(selectTime)})
        } else {
            // 検索値のみ
            return realmViewModel.records.filter({$0.productName.contains(searchText)})
        }
    }
    
    
    var body: some View {
        
        
        VStack(spacing:0) {
            // MARK: - Header
            HeaderView(
                headerTitle: "寄付履歴",
                trailingIcon: "plus.circle.fill",
                trailingAction: {
                    showEntryView = true
                }
            )
            
            // MARK: - SearchBox
            SearchBoxView(searchText: $searchText)
            
            // MARK: - 寄付金額＆日付Picker
            HStack {
                
                // MARK: - Display
                SumDonationAmountView(selectTime: $selectTime)
                
                Spacer()
                
                // MARK: - Picker
                PickerTimeView(selectTime: $selectTime)
                
            }.frame(width:DeviceSizeUtility.deviceWidth)
                .padding([.top,.horizontal])
                .background(Asset.Colors.baseColor.swiftUIColor)
            
            
            // MARK: - List
            if realm_filteringAllFuludata.count != 0 {
                List(realm_filteringAllFuludata) { item in
                    
                    NavigationLink {
                        DetailFuluLogView(
                            item: item,
                            isOn: item.request,
                            isFavorite: false
                        )
                    } label: {
                        RowFuluLogView(item: item, isFavorite: false)
                    }
                    
                }.scrollContentBackground(.hidden)
                    .background(Asset.Colors.baseColor.swiftUIColor)
            } else {
                Spacer()
                
                Text("表示するデータがありません。")
                    .foregroundStyle(Asset.Colors.exText.swiftUIColor)
                
                Spacer()
            }
            
        }.ignoresSafeArea(.keyboard, edges: .bottom)
            .navigationBarHidden(true)
            .background(Asset.Colors.baseColor.swiftUIColor)
            .sheet(isPresented: $showEntryView, content: {
                EntryFuluLogView(isModal: $showEntryView)
            })
    }
}

struct ListFuluLogView_Previews: PreviewProvider {
    static var previews: some View {
        ListFuluLogView()
    }
}

