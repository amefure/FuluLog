//
//  DeviceSizeModel.swift
//  FuluLog
//
//  Created by t&a on 2023/03/16.
//

import UIKit
import SwiftUI

class DeviceSizeUtility {
    
    static var deviceWidth: CGFloat {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return 0 }
        return window.screen.bounds.width
    }

    static var deviceHeight: CGFloat {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return 0 }
        return window.screen.bounds.height
    }

    static var isSESize: Bool {
        return deviceWidth < 400
    }

    static var isiPadSize: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var flexWidth: Double {
        return isiPadSize ? deviceWidth / 1.5 : deviceWidth
    }
}
