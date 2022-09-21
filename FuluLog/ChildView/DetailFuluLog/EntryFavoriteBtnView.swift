//
//  EntryFavoriteBtnView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/21.
//

import SwiftUI

// DetailFuluLogView > EntryFavoriteBtnView

struct EntryFavoriteBtnView: View {
    
    // MARK: - Models
    let fileController = FileController()
    @EnvironmentObject var allFulu:AllFuluLog
    
    // MARK: - Receive
    @State var item:FuluLog
    
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
                    let data = FuluLog(productName: item.productName, amount: item.amount, municipality: item.municipality, url: item.url,memo: item.memo,time: item.time)
                    fileController.saveFavoriteJson(data)
                    allFulu.setAllFavoriteData()
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

struct EntryFavoriteBtnView_Previews: PreviewProvider {
    static var previews: some View {
        EntryFavoriteBtnView(item: FuluLog(productName: "", amount: 0, municipality: "", url: ""))
    }
}
