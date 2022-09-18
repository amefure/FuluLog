//
//  SearchBoxView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/17.
//

import SwiftUI

// ListFuluLogView > SearchBoxView
struct SearchBoxView: View {
    
    @State var inputText:String = ""
    @Binding var searchText:String
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass").font(.system(size: 15))
            TextField("ほたて", text: $inputText).lineLimit(1)
            Button(action: {
                searchText = inputText
            }, label: {
                Text("検索")
            })
        }.padding(8).background(Color(red: 0.9, green: 0.9, blue: 0.9)).opacity(0.8).cornerRadius(5).padding([.top,.horizontal]).background(Color("BaseColor"))
    }
}

struct SearchBoxView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBoxView(searchText: Binding.constant(""))
    }
}
