//
//  ContentView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/10.
//

import SwiftUI

struct ContentView: View {
    // MARK: - View
    @State var selectedTag:Int = 1      //  タブビュー
    
    private var userDefaultsViewModel = UserDefaultsViewModel()
    
    init() {
           // リストの背景色を変更
           UITableView.appearance().backgroundColor = UIColor(named: "BaseColor")
       }
    
    var body: some View {
        TabView(selection:$selectedTag){
            
            // MARK: - Entry
            EntryFuluLogView(isModal: Binding.constant(false)).tabItem{
                Image(systemName:"plus.circle")
            }.tag(1)
            
            
            // MARK: - List
            ListFuluLogView().tabItem{
                Image(systemName:"list.bullet")
            }.tag(2)
            
            // MARK: - Favorite
            FavoriteFuluLogView().tabItem{
                Image(systemName:"star.fill")
            }.tag(3)
            
            // MARK: - Setting
            SettingView().tabItem{
                Image(systemName:"gear")
            }.tag(4)
            
        }
        .onAppear{
            if userDefaultsViewModel.getMigrationKey() == 0{
                TransferConfigurationViewModel().jsonTransforRealmDB()
                userDefaultsViewModel.setMigrationKey(verNum: 1.0)
            }
//            RealmDataBaseModel().deleteAllTable()
//            userDefaultsViewModel.setMigrationKey(verNum: 0)
        }
        .accentColor(.orange)
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
