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
    private let validation = ValidationViewModel()
    private let realmDataBase = RealmDataBaseViewModel()
    private let userDefaults = UserDefaultsViewModel()
    private let deviceSize = DeviceSizeViewModel()
    
    @ObservedResults(FuluLogRecord.self) var allFuleRelam
    
    @State var searchText:String = ""    // Binding-SearchBoxView
    @State var selectTime:String = "all" // Binding-PickerTimeView
    
    // MARK: - List Filtering Data
   private var realm_filteringAllFuludata:[FuluLogRecord]{
        if searchText.isEmpty && selectTime == "all"{
            // フィルタリングなし
            return allFuleRelam.reversed().sorted(by: {$0.time > $1.time})
        }else if searchText.isEmpty && selectTime != "all" {
            // 年数のみ
            return allFuleRelam.filter({$0.timeString.contains(selectTime)}).sorted(by: {$0.time > $1.time})
        }else if searchText.isEmpty == false &&  selectTime != "all" {
            // 検索値＆年数
            return allFuleRelam.reversed().filter({$0.productName.contains(searchText)}).filter({$0.timeString.contains(selectTime)}).sorted(by: {$0.time > $1.time})
        }else{
            // 検索値のみ
            return allFuleRelam.reversed().filter({$0.productName.contains(searchText)}).sorted(by: {$0.time > $1.time})
        }
    }
    

    var body: some View {
        
        NavigationView{
            VStack(spacing:0){
                // MARK: - Header
                HeaderView(headerTitle: "寄付履歴")
                
                // MARK: - SearchBox
                SearchBoxView(searchText: $searchText)
                
                // MARK: - 寄付金額＆日付Picker
                HStack{
                    
                    // MARK: - Display
                    SumDonationAmountView(selectTime: $selectTime)
                    
                    Spacer()
                    
                    // MARK: - Picker
                    PickerTimeView(selectTime: $selectTime)
                    
                }.frame(width:deviceSize.deviceWidth).padding([.top,.horizontal]).background(Color("BaseColor"))
                
                
                // MARK: - List
                    List(realm_filteringAllFuludata){ item in
                        NavigationLink(destination: {DetailFuluLogView(item: item,isOn: item.request,isFavorite: false)
                        }, label: {
                            RowFuluLogView(item: item, isFavorite: false)
                        })
                       
                    }.listStyle(GroupedListStyle())
                    
                
            }.ignoresSafeArea(.keyboard, edges: .bottom)
            .navigationBarHidden(true)
        }.navigationViewStyle(.stack) // NavigationView
    }
}

struct ListFuluLogView_Previews: PreviewProvider {
    static var previews: some View {
        ListFuluLogView()
    }
}
