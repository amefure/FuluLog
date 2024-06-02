//
//  ValidationUtility.swift
//  FuluLog
//
//  Created by t&a on 2023/03/16.
//

import UIKit

class ValidationUtility {

    /// 数値が有効な数値ならtrue
    /// 数値が-1または小さいならfalse
    static func checkNegativeAmount (_ amount: Int) -> Bool {
        return !(amount <= -1)
    }
        
    /// 文字列が空かどうか
    /// 空でないならtrue
    /// 空ならfalse
    static func checkNonEmptyText(_ text: String) -> Bool {
        return !text.isEmpty
    }
    
    /// URLが有効かどうか
    static func checkValidURL (_ urlStr: String) -> Bool {
        guard let encurl = urlStr.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            return false
        }
        if let url = NSURL(string: encurl) {
            return UIApplication.shared.canOpenURL(url as URL)
        } else {
            return false
        }
    }
    
    /// 文字列が
    /// バリデーション正常 → true
    /// バリデーションアウト → false
    static func checkInputValidity(text: String, amount: Int, urlStr: String) -> Bool {
        // 必須入力は商品名と寄付金額のみ
        if checkNonEmptyText(text) && checkNegativeAmount(amount) {
            // URL入力値があるならバリデーション
            if checkNonEmptyText(urlStr) {
                return checkValidURL(urlStr) // URL 有効 OK / 無効 NG
            } else {
                return true       // 必須事項記入あり　URL 入力なし OK
            }
        }
        return false // 必須事項記入なし NG
    }
}
