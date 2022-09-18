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
    
    @ObservedObject var allFulu = AllFuluLog()
    
    init() {
           // リストの背景色を変更
           UITableView.appearance().backgroundColor = UIColor(named: "BaseColor")
       }
    
    var body: some View {
        TabView{
            
            // MARK: - Entry
            EntryFuluLogView().environmentObject(allFulu).tabItem{
                Image(systemName:"plus.circle")
            }.tag(1)
            
            // MARK: - List
            ListFuluLogView().environmentObject(allFulu).tabItem{
                Image(systemName:"list.bullet")
            }.tag(2)
            
            // MARK: - Setting
            SettingView().environmentObject(allFulu).tabItem{
                Image(systemName:"gear")
            }.tag(3)
            
        }.preferredColorScheme(.light)
        .accentColor(.orange)
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
