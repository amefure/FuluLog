//
//  ContentView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/10.
//

import SwiftUI

struct RootView: View {
    @State private var selectedTag = 0
    
    var body: some View {
        VStack(spacing: 0) {
            
            TabView(selection: $selectedTag) {
                
                // MARK: - List
                NavigationView {
                    ListFuluLogView()
                }.navigationViewStyle(.stack)
                    .tabItem {
                        Image(systemName:"list.bullet")
                    }.tag(0)
                
                // MARK: - Favorite
                NavigationView {
                    FavoriteFuluLogView()
                }.navigationViewStyle(.stack)
                    .tabItem {
                        Image(systemName:"star.fill")
                    }.tag(1)
                
                // MARK: - Setting
                NavigationView {
                    SettingView()
                }.navigationViewStyle(.stack)
                    .tabItem {
                        Image(systemName:"gearshape.fill")
                    }.tag(2)
                
            }
            
            // MARK: - AdMob
            AdMobBannerView()
                .frame(height: 60)
        }.accentColor(.orange)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
