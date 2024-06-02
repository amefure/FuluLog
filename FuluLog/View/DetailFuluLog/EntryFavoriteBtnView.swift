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
    var item:FuluLogRecord
    
    // MARK: - ViewModels
    private let realmDataBase = RealmDataBaseViewModel()
    
    @State var isAlertFavorite:Bool = false
    @State var isAlertEntry:Bool = false
    
    var body: some View {
        
        Button(action: {
            isAlertFavorite = true
        }, label: {
            Image(systemName:"star")
        })
        .alert(Text("お気に入りにコピーしますか？"),isPresented: $isAlertFavorite){
            Button(action: {
            }, label: {
                Text("キャンセル")
            })
            Button(action: {
                realmDataBase.favorite_createRecord(productName: item.productName, amount: item.amount, municipality: item.municipality, url: item.url,memo: item.memo,time: DateFormatUtility().getConvertStringDate(item.timeString))
                isAlertEntry = true
            }, label: {
                Text("OK")
            })
        } message: {
            Text("")
        }
        .alert(Text("Success!"),isPresented: $isAlertEntry){
            Button(action: {
                
            }, label: {
                Text("OK")
            })
        } message: {
            Text("お気に入りにコピーしました。")
        }
    }
}

