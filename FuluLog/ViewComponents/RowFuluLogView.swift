//
//  RowFuluLogView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/10.
//

import SwiftUI

// ListFuluLogView > RowFuluLogView
// FavoriteFuluLogView > RowFuluLogView

struct RowFuluLogView: View {
    
    var item:FuluLog?
    var item2:FuluLogRecord?
    var isFavorite:Bool // Favoriteからの呼出
    
    var displayDateViewModel = DisplayDateViewModel()
    
    var body: some View {
        
        if item2 == nil{
            
        HStack{
            Text("\(item!.time)")
                .font(.system(size: 10))
                .foregroundColor(.gray)
                .frame(width:60)
            
            if isFavorite == false{
                Image(systemName: item!.request == true ? "checkmark.seal.fill" : "checkmark.seal")
                    .foregroundColor(item!.request == true ? .orange : .gray)
            }else{
                Image(systemName: "star.fill").foregroundColor(.yellow)
            }
            
            Text(item!.productName)
                .fontWeight(.bold)
                .lineLimit(1)
            
            
            Spacer()
            HStack{
                Text("\(item!.amount)").foregroundColor(.orange).lineLimit(1)
                Text("円").font(.system(size: 10)).offset(x: 0, y: 3)
            }
            
        }
            
        }else{
        
        HStack{
            Text("\(displayDateViewModel.getDateDisplayFormatString(item2!.time))")
                .font(.system(size: 10))
                .foregroundColor(.gray)
                .frame(width:60)
            
            if isFavorite == false{
                Image(systemName: item2!.request == true ? "checkmark.seal.fill" : "checkmark.seal")
                    .foregroundColor(item2!.request == true ? .orange : .gray)
            }else{
                Image(systemName: "star.fill").foregroundColor(.yellow)
            }
            
            Text(item2!.productName)
                .fontWeight(.bold)
                .lineLimit(1)
            
            
            Spacer()
            HStack{
                Text("\(item2!.amount)").foregroundColor(.orange).lineLimit(1)
                Text("円").font(.system(size: 10)).offset(x: 0, y: 3)
            }
            
        }
        }
    }
}


