//
//  ShareButton.swift
//  FuluLog
//
//  Created by t&a on 2023/03/28.
//

import SwiftUI

struct ShareButton: View {
    
    private let shareLinkViewModel = ShareLinkViewModel()
    
    var shareText:String
    var shareLink:String
    
    var body: some View {

        Button(action: {
            shareLinkViewModel.shareApp(shareText: "寄付したふるさと納税を管理できるアプリ「ふるログ」を使ってみてね♪", shareLink: "https://apps.apple.com/jp/app/%E3%81%B5%E3%82%8B%E3%83%AD%E3%82%B0/id1644963031")
        }) {
            HStack{
                Image(systemName:"star.bubble").frame(width: 30).frame(width: 30).foregroundColor(.orange)
                Text("ふるログをオススメする")
            }
        }
    }
}

