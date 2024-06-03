//
//  FavoriteFuluLogView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/18.
//

import SwiftUI
import RealmSwift

struct FavoriteFuluLogView: View {
    
    @ObservedObject private var realmViewModel = RealmDataBaseViewModel.shared
    @State private var showEntryView = false
    
    var body: some View {
        VStack(spacing:0) {
            // MARK: - Header
            HeaderView(
                headerTitle: "お気に入りリスト",
                trailingIcon: "star.bubble",
                trailingAction: { showEntryView = true}
            )
            
            if realmViewModel.favoriteRecords.count != 0 {
                // MARK: - List
                List(realmViewModel.favoriteRecords) { item in
                    
                    NavigationLink {
                        DetailFuluLogView(
                            item: item,
                            isOn: item.request,
                            isFavorite: true
                        )
                    } label: {
                        RowFuluLogView(item: item, isFavorite: true)
                    }

                }.listStyle(GroupedListStyle())
                    .scrollContentBackground(.hidden)
                    .background(Asset.Colors.baseColor.swiftUIColor)
            } else {
                Spacer()
                
                Text("表示するデータがありません。")
                    .foregroundStyle(Asset.Colors.exText.swiftUIColor)
                
                Spacer()
            }
            
        }.background(Asset.Colors.baseColor.swiftUIColor)
            .navigationBarHidden(true)
            .sheet(isPresented: $showEntryView, content: {
                EntryFuluLogView(isModal: $showEntryView, isFavorite: true)
            })
    }
}

struct FavoriteFuluLogView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteFuluLogView()
    }
}
