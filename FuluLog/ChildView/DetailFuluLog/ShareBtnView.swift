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
    @State var item:FuluLog
    
    // シェアボタン
    func shareApp(shareText: String, shareLink: String) {
        let items = [shareText, URL(string: shareLink)!] as [Any]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popPC = activityVC.popoverPresentationController {
                popPC.sourceView = activityVC.view
                popPC.barButtonItem = .none
                popPC.sourceRect = activityVC.accessibilityFrame
            }
        }
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let rootVC = windowScene?.windows.first?.rootViewController
        rootVC?.present(activityVC, animated: true,completion: {})
    }
    
    var body: some View {
        Button(action: {
            if item.url.isEmpty{
                shareApp(shareText: "ふるさと納税「\(item.productName)」がおすすめだよ！\n「ふるログ」でふるさと納税を管理してみてね♪", shareLink: "https://apps.apple.com/jp/app/mapping/id1639823172")
            }else{
                shareApp(shareText: "ふるさと納税「\(item.productName)」がおすすめだよ！", shareLink: item.url)
            }
        }, label: {
            Image(systemName: "square.and.arrow.up")
        })
    }
}

struct ShareBtnView_Previews: PreviewProvider {
    static var previews: some View {
        ShareBtnView(item: FuluLog(productName: "", amount: 0, municipality: "", url: ""))
    }
}
