//
//  EntryFavoriteBtnView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/21.
//

import SwiftUI

// DetailFuluLogView > EntryFavoriteBtnView

struct EntryFavoriteBtnView: View {
    
    // MARK: - ViewModels
    private let realmDataBase = RealmDataBaseViewModel()
    
    // MARK: - Models
    let fileController = FileController()
    @EnvironmentObject var allFulu:AllFuluLog
    

    
    // MARK: - Receive
//    @State var item:FuluLog
    var item:FuluLogRecord
    
    @State var isAlertFavorite:Bool = false
    @State var isAlertEntry:Bool = false
    
    var body: some View {
        
        Button(action: {
            isAlertFavorite = true
        }, label: {
            Image(systemName:"star")
        })
        .alert(Text("お気に入りにコピーしますか？"),
               isPresented: $isAlertFavorite,
               actions: {
            
            
            Button(action: {
                
            }, label: {
                Text("キャンセル")
            })
            Button(
                action: {
                    // -- JSON
//                    let data = FuluLog(productName: item.productName, amount: item.amount, municipality: item.municipality, url: item.url,memo: item.memo,time: item.time)
//                    fileController.saveFavoriteJson(data)
//                    allFulu.setAllFavoriteData()
                    // -- JSON
                    
                    // -- Realm
                    realmDataBase.favorite_createRecord(productName: item.productName, amount: item.amount, municipality: item.municipality, url: item.url,memo: item.memo,time: DisplayDateViewModel().getConvertStringDate(item.timeString))
                    // -- Realm
                    isAlertEntry = true
                }, label: {
                    Text("Yes")
                })
        }, message: {
            Text("")
        })
        .alert(Text("コピーしました。"),
               isPresented: $isAlertEntry,
               actions: {
            
            Button(
                action: {
                }, label: {
                    Text("OK")
                })
        }, message: {
            Text("")
        })
    }
}

