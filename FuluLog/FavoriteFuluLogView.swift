//
//  FavoriteFuluLogView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/18.
//

import SwiftUI

struct FavoriteFuluLogView: View {
    
    // MARK: - Models
    let fileController = FileController()
    @EnvironmentObject var allFulu:AllFuluLog
    
    // MARK: - View
    @State var isModal:Bool = false
    
    var body: some View {
        NavigationView{
            VStack(spacing:0){
                // MARK: - Header
                HeaderView(headerTitle: "お気に入りリスト",rightImageName: "star.bubble", parentRightButtonFunction: { isModal = true})
                
                // MARK: - List
                List(allFulu.allFavoriteData.reversed().sorted(by: {$0.time > $1.time})){ item in
                    NavigationLink(destination: {DetailFuluLogView(item: item,isOn: item.request,isFavorite: true).environmentObject(allFulu)}, label: {
                        RowFuluLogView(item: item,isFavorite: true)
                        }
                    )
                }.listStyle(GroupedListStyle())
                
                // MARK: - AdMob
                AdMobBannerView().frame(width:UIScreen.main.bounds.width,height: 60).padding(.bottom)
                
            }.sheet(isPresented: $isModal, content: {
                EntryFavoriteFuluLogView(isModal: $isModal)
            })
            .navigationBarHidden(true)
        }.navigationViewStyle(.stack) // NavigationView
    }
}

struct FavoriteFuluLogView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteFuluLogView()
    }
}
