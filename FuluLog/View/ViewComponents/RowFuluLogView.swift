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
    
    // MARK: - ViewModels
    private let displayDate = DisplayDateViewModel()
    
    var item:FuluLogRecord?
    var isFavorite:Bool // Favoriteからの呼出
    
    var body: some View {
        
        HStack{
            Text("\(displayDate.getDateDisplayFormatString(item!.time))")
                .font(.system(size: 10))
                .foregroundColor(.gray)
                .frame(width:60)
            
            if isFavorite == false{
                Image(systemName: item!.request == true ? "checkmark.seal.fill" : "checkmark.seal")
                    .foregroundColor(item!.request == true ? .orange : .gray)
            }else{
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
            
            Text(item!.productName)
                .fontWeight(.bold)
                .lineLimit(1)
            
            
            Spacer()
            HStack{
                Text("\(item!.amount)")
                    .foregroundColor(.orange)
                    .lineLimit(1)
                Text("円")
                    .font(.system(size: 10))
                    .offset(x: 0, y: 3)
            }
        }
    }
}


