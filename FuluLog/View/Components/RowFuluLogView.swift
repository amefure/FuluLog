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
    private let dateFormatUtility = DateFormatUtility()
    
    public var item: FuluLogRecord?
    public var isFavorite: Bool     // Favoriteからの呼出かどうか
    
    var body: some View {
        
        HStack {
            if let item = item {
                
                Text("\(dateFormatUtility.getDateDisplayFormatString(item.time))")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
                    .fontWeight(.bold)
                    .frame(width: 65)
                
                if isFavorite == false {
                    Image(systemName: item.request == true ? "checkmark.seal.fill" : "checkmark.seal")
                        .foregroundColor(item.request == true ? .orange : .gray)
                } else {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
                
                Text(item.productName)
                    .fontWeight(.bold)
                    .lineLimit(1)
                
                Spacer()
                
                HStack {
                    Text("\(item.amount)")
                        .font(.system(size: 18))
                        .foregroundStyle(.orange)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Text("円")
                        .font(.system(size: 11))
                        .offset(x: 0, y: 3)
                }
            }
        }.frame(height: 40)
    }
}


