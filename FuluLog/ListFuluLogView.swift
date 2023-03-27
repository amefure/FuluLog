//
//  ListFuluLogView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/10.
//

import SwiftUI
import RealmSwift

struct ListFuluLogView: View {
    
//    @EnvironmentObject var allFulu:AllFuluLog
    
    // MARK: - ViewModels
    private let validation = ValidationViewModel()
    private let realmDataBase = RealmDataBaseViewModel()
    private let userDefaults = UserDefaultsViewModel()
    
    @ObservedResults(FuluLogRecord.self) var allFuleRelam
    
    @State var searchText:String = "" // Binding-SearchBoxView
    
    @State var selectTime:String = "all" // Binding-PickerTimeView
    
    @State var test = false
    
//    // MARK: - List
//    var filteringAllFuludata:[FuluLog]{
//        if searchText.isEmpty && selectTime == "all"{
//            // フィルタリングなし
//            return allFulu.allData.reversed().sorted(by: {$0.time > $1.time})
//        }else if searchText.isEmpty && selectTime != "all" {
//            // 年数のみ
//            return allFulu.allData.reversed().filter({$0.time.contains(selectTime)}).sorted(by: {$0.time > $1.time})
//        }else if searchText.isEmpty == false &&  selectTime != "all" {
//            // 検索値＆年数
//            return allFulu.allData.reversed().filter({$0.productName.contains(searchText)}).filter({$0.time.contains(selectTime)}).sorted(by: {$0.time > $1.time})
//        }else{
//            // 検索値のみ
//            return allFulu.allData.reversed().filter({$0.productName.contains(searchText)}).sorted(by: {$0.time > $1.time})
//        }
//    }
    
    // MARK: - List
    var realm_filteringAllFuludata:[FuluLogRecord]{
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
                    SumDonationAmountView(selectTime: $selectTime)//.environmentObject(allFulu)
                    
                    
                    Spacer()
                    
                    // MARK: - Picker
                    PickerTimeView(selectTime: $selectTime)//.environmentObject(allFulu)
                    
                }.frame(width:UIScreen.main.bounds.width).padding([.top,.horizontal]).background(Color("BaseColor"))
                
                
                // MARK: - List
//                if test{
                    List(realm_filteringAllFuludata){ item in
                        NavigationLink(destination: {DetailFuluLogView(item2: item,isOn: item.request,isFavorite: false)
                        }, label: {
                            RowFuluLogView(item: nil,item2: item, isFavorite: false)
                        }
                        )
                       
                    }.listStyle(GroupedListStyle())
//                }else{
                    
//                    List(filteringAllFuludata){ item in
//                        NavigationLink(destination: {DetailFuluLogView(item: item,item2: nil,isOn: item.request,isFavorite: false).environmentObject(allFulu)}, label: {
//                            RowFuluLogView(item: item,item2: nil,isFavorite: false)
//                        }
//                        )
//                    }.listStyle(GroupedListStyle())
//                }
                    
                
                // MARK: - AdMob
                AdMobBannerView().frame(width:UIScreen.main.bounds.width,height: 60).padding(.bottom)
                
            }
            .navigationBarHidden(true)
        }.navigationViewStyle(.stack) // NavigationView
        
    }
}

struct ListFuluLogView_Previews: PreviewProvider {
    static var previews: some View {
        ListFuluLogView()
    }
}
