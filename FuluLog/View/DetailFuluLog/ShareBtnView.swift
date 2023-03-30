//
//  ShareBtnView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/21.
//

import SwiftUI

// DetailFuluLogView > ShareBtnView

struct ShareBtnView: View {
    
    // MARK: - Receive
    var item:FuluLogRecord
    
    // MARK: - ViewModels
    private let shareLinkViewModel = ShareLinkViewModel()
    
    var body: some View {
        Button(action: {
            if item.url.isEmpty{
                shareLinkViewModel.shareApp(shareText: "ふるさと納税「\(item.productName)」がおすすめだよ！\n「ふるログ」でふるさと納税を管理してみてね♪", shareLink: "https://apps.apple.com/jp/app/mapping/id1639823172")
            }else{
                shareLinkViewModel.shareApp(shareText: "ふるさと納税「\(item.productName)」がおすすめだよ！", shareLink: item.url)
            }
        }, label: {
            Image(systemName: "square.and.arrow.up")
        })
    }
}

