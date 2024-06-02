//
//  SearchBoxView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/17.
//

import SwiftUI

// ListFuluLogView > SearchBoxView
struct SearchBoxView: View {
    
    @Binding var searchText: String
    @State private var inputText = ""
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 15))
            
            TextField("ほたて", text: $inputText)
                .lineLimit(1)
                .foregroundStyle(Asset.Colors.exText.swiftUIColor)
            
            Button {
                searchText = inputText
            } label: {
                Text("検索")
                    .fontWeight(.bold)
            }

        }.padding(8)
            .background(Asset.Colors.foundationColor.swiftUIColor)
            .opacity(0.8)
            .cornerRadius(5)
            .padding([.top,.horizontal])
            .background(Asset.Colors.baseColor.swiftUIColor)
    }
}

struct SearchBoxView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBoxView(searchText: Binding.constant(""))
    }
}
