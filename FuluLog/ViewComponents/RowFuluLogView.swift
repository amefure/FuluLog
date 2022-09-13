//
//  RowFuluLogView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/10.
//

import SwiftUI

struct RowFuluLogView: View {
    var item:FuluLog
    
    var body: some View {
        HStack{
            Text("\(item.time)")
                .font(.system(size: 10))
                .foregroundColor(.gray)
                
            
            Image(systemName: item.request == true ? "checkmark.seal.fill" : "checkmark.seal")
                .foregroundColor(item.request == true ? .orange : .gray)

            Text(item.productName)
                .fontWeight(.bold)
                .lineLimit(1)
                
            
            Spacer()
            HStack{
                Text("\(item.amount)").foregroundColor(.orange).lineLimit(1)
                Text("円").font(.system(size: 10)).offset(x: 0, y: 3)
            }
        
        }
    }
}

struct RowFuluLogView_Previews: PreviewProvider {
    static var previews: some View {
        RowFuluLogView(item: FuluLog(productName: "", amount: 0, municipality: "", url: ""))
    }
}
