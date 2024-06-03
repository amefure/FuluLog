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
    public var item: FuluLogRecord
    
    var body: some View {
        Button {
            if item.url.isEmpty {
                ShareContentUtility.share(text: "ふるさと納税「\(item.productName)」がおすすめだよ！\n「ふるログ」でふるさと納税を管理してみてね♪", urlStr: "https://apps.apple.com/jp/app/mapping/id1639823172")
            } else {
                ShareContentUtility.share(text: "ふるさと納税「\(item.productName)」がおすすめだよ！", urlStr: item.url)
            }
        } label: {
            Image(systemName: "square.and.arrow.up")
                .foregroundStyle(Asset.Colors.exText.swiftUIColor)
        }
    }
}

