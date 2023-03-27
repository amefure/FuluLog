//
//  ValidationViewModel.swift
//  FuluLog
//
//  Created by t&a on 2023/03/16.
//

import UIKit

class ValidationViewModel  {
    
    public func validatuonAmount (_ amount:Int) -> Bool{
        if amount <= -1  {
            return false
        }else{
            return true
        }
    }
    
    
    public func validatuonInput(_ text:String) -> Bool{
        if text.isEmpty {
            return false
        }else{
            return true
        }
    }
    
    public func validationUrl (_ urlStr: String) -> Bool {
        guard let encurl = urlStr.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            return false
        }
        if let url = NSURL(string: encurl) {
            return UIApplication.shared.canOpenURL(url as URL)
        }else{
            return false
        }
        
    }
    
}
