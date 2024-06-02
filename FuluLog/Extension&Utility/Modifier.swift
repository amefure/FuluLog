//
//  Modifier.swift
//  FuluLog
//
//  Created by t&a on 2023/03/29.
//

import SwiftUI

// MARK: - Extension Modifier
struct InputItemBackView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: DeviceSizeUtility.flexWidth, height: 30)
            .background(Asset.Colors.subColor.swiftUIColor)
            .foregroundColor(Asset.Colors.themaColor.swiftUIColor)
    }
}

extension View {
    func inputItemBackView() -> some View {
        modifier(InputItemBackView())
    }
}
