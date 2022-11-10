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
    @FocusState  var isInputActive:Bool  // ナンバーパッドのフォーカス
    
    init() {
           // リストの背景色を変更
           UITableView.appearance().backgroundColor = UIColor(named: "BaseColor")
       }
    
    var body: some View {
        TabView(selection:$selectedTag){
            
            // MARK: - Entry
            EntryFuluLogView().environmentObject(allFulu).tabItem{
                Image(systemName:"plus.circle")
            }.tag(1).focused($isInputActive)
            
            
            // MARK: - List
            ListFuluLogView().environmentObject(allFulu).tabItem{
                Image(systemName:"list.bullet")
            }.tag(2)
            
            // MARK: - Favorite
            FavoriteFuluLogView().environmentObject(allFulu).tabItem{
                Image(systemName:"star.fill")
            }.tag(3)
            
            // MARK: - Setting
            SettingView().environmentObject(allFulu).tabItem{
                Image(systemName:"gear")
            }.tag(4)
            
        }.preferredColorScheme(.light)
        .accentColor(.orange)
        .ignoresSafeArea()
        .toolbar {
                // ツールバーを親の一番上の要素に実装
                ToolbarItemGroup(placement: .keyboard) {
                if selectedTag == 1 {
                    Spacer()  // 右寄せにする
                    Button("閉じる") {
                        isInputActive = false
                    }
                }
                }
    }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
