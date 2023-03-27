//
//  DeviceSizeModel.swift
//  FuluLog
//
//  Created by t&a on 2023/03/16.
//

import UIKit

class DeviceSizeModel {
    
    static let deviceWidth = UIScreen.main.bounds.width
    static let deviceHeight = UIScreen.main.bounds.height
    // 端末設定のカレンダー
    static let calendar = Calendar.current
    
    static var isSESize:Bool {
        if deviceWidth < 400{
            return true
        }else{
            return false
        }
    }
    
    static var isiPadSize:Bool {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return true
        }else{
            return false
        }
    }
    
    static var flexWidth:Double {
        if DeviceSizeModel.isiPadSize {
            return DeviceSizeModel.deviceWidth/1.5
        }else{
            return DeviceSizeModel.deviceWidth
        }
    }
}

