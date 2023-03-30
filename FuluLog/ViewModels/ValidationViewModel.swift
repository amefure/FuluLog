//
//  ValidationViewModel.swift
//  FuluLog
//
//  Created by t&a on 2023/03/16.
//

import UIKit

class ValidationViewModel  {

    public func checkNegativeAmount (_ amount:Int) -> Bool{
        if amount <= -1  {
            return false
        }else{
            return true
        }
    }
        
    public func checkNonEmptyText(_ text:String) -> Bool{
        if text.isEmpty {
            return false
        }else{
            return true
        }
    }
    
    public func checkValidURL (_ urlStr: String) -> Bool {
        guard let encurl = urlStr.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            return false
        }
        if let url = NSURL(string: encurl) {
            return UIApplication.shared.canOpenURL(url as URL)
        }else{
            return false
        }
    }
    
    public func checkInputValidity(text:String,amount:Int,urlStr: String)-> Bool{
        // 必須入力は商品名と寄付金額のみ
        if self.checkNonEmptyText(text) && self.checkNegativeAmount(amount)  {
            if self.checkNonEmptyText(urlStr){ // 入力値があるならバリデーション
                if self.checkValidURL(urlStr) {
                    return false // URL 有効 OK
                }
                return true // URL 無効 NG
            }else{
                return false // 必須事項記入あり　URL 入力なし OK
            }
        }
        return true // 必須事項記入なし NG
    }
    
}
