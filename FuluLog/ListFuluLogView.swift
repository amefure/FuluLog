//
//  ListFuluLogView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/10.
//

import SwiftUI

struct ListFuluLogView: View {
    
    @EnvironmentObject var allFulu:AllFuluLog
    
    var body: some View {
        
        NavigationView{
            VStack(spacing:0){
                // MARK: - Header
                HeaderView(headerTitle: "リスト")
                
                // MARK: - List
                List(allFulu.allData.reversed()){ item in
                    NavigationLink(destination: {DetailFuluLogView(item: item,isOn: item.request).environmentObject(allFulu)}, label: {
                        RowFuluLogView(item: item)
                    }
                    )
                }.listStyle(GroupedListStyle())
                
                // MARK: - AdMob
                AdMobBannerView().frame(width:UIScreen.main.bounds.width,height: 40).padding(.bottom)
                
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
