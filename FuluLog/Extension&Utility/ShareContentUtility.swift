//
//  ShareContentUtility.swift
//  FuluLog
//
//  Created by t&a on 2024/05/31.
//

import UIKit
import SwiftUI

class ShareContentUtility {
    
    /// シェアロジック
    static func share(text: String? = nil, image: Image? = nil, urlStr: String? = nil) {
        var items: [Any] = []
        if let text = text {
            items.append(text)
        }
        if let image = image {
            items.append(image)
        }
        if let urlStr = urlStr,
           let url = URL(string: urlStr) {
            items.append(url)
        }
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
        rootVC?.present(activityVC, animated: true, completion: {})
    }
}
