//
//  ContentView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/10.
//

import SwiftUI

struct RootView: View {
    @State private var selectedTag = 1
    
    private var userDefaultsViewModel = UserDefaultsManager()
    
    var body: some View {
        VStack(spacing: 0) {
            
            TabView(selection: $selectedTag) {
                
                // MARK: - List
                ListFuluLogView()
                    .tabItem {
                        Image(systemName:"list.bullet")
                    }.tag(1)
                
                // MARK: - Favorite
                FavoriteFuluLogView()
                    .tabItem {
                        Image(systemName:"star.fill")
                    }.tag(2)
                
                // MARK: - Setting
                SettingView()
                    .tabItem {
                        Image(systemName:"gearshape.fill")
                    }.tag(3)
                
            }
            
            // MARK: - AdMob
            AdMobBannerView()
                .frame(height: 60)
        }
        .onAppear{
            if userDefaultsViewModel.getMigrationKey() == 0 {
                TransferConfigurationViewModel().jsonTransforRealmDB()
                userDefaultsViewModel.setMigrationKey(1.0)
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
        RootView()
    }
}
