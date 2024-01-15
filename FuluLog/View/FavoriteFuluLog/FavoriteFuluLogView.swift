//
//  FavoriteFuluLogView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/18.
//

import SwiftUI
import RealmSwift

struct FavoriteFuluLogView: View {
    
    @ObservedResults(FavoriteFuluLogRecord.self) var allFavoriteFuluRelam
    
    // MARK: - View
    @State var isModal:Bool = false
    
    var body: some View {
        NavigationView{
            VStack(spacing:0){
                // MARK: - Header
                HeaderView(headerTitle: "お気に入りリスト",rightImageName: "star.bubble", parentRightButtonFunction: { isModal = true})
                
                // MARK: - List
                List(allFavoriteFuluRelam.reversed().sorted(by: {$0.time > $1.time})){ item in
                    NavigationLink(destination: {
                        DetailFuluLogView(item: item,isOn: item.request,isFavorite: true)  
                    },label: {
                        RowFuluLogView(item: item,isFavorite: true)
                        }
                    )
                }.listStyle(GroupedListStyle())
                
            }.sheet(isPresented: $isModal, content: {
                EntryFuluLogView(isModal:$isModal,isFavorite: true)
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
