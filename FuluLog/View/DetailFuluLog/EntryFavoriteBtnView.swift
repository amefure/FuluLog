//
//  EntryFavoriteBtnView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/21.
//

import SwiftUI

// DetailFuluLogView > EntryFavoriteBtnView

struct EntryFavoriteBtnView: View {
    
    // MARK: - Receive
    public var item: FuluLogRecord
    
    // MARK: - ViewModels
    @ObservedObject private var realmViewModel = RealmDataBaseViewModel.shared
    
    @State private var isAlertFavorite:Bool = false
    @State private var isAlertEntry:Bool = false
    
    var body: some View {
        Button {
            isAlertFavorite = true
        } label: {
            Image(systemName:"star")
        }.alert(Text("お気に入りにコピーしますか？"),isPresented: $isAlertFavorite){
            Button { } label: {
                Text("キャンセル")
            }
            Button {
                realmViewModel.favorite_createRecord(
                    productName: item.productName,
                    amount: item.amount,
                    municipality: item.municipality,
                    url: item.url,
                    memo: item.memo,
                    time: DateFormatUtility().getConvertStringDate(item.timeString)
                )
                isAlertEntry = true
            } label: {
                Text("OK")
            }
        } message: {
            Text("")
        }
        .alert(Text("Success!"),isPresented: $isAlertEntry){
            Button { } label: {
                Text("OK")
            }
        } message: {
            Text("お気に入りにコピーしました。")
        }
    }
}

