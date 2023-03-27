//
//  DisplayDateViewModel.swift
//  FuluLog
//
//  Created by t&a on 2023/03/16.
//

import UIKit

class DisplayDateViewModel {
    // MARK: - 日付表示用モデル
    // DateFormatterをプロパティに持つ
    // 日付の表示形式を変更する
    
    private let df:DateFormatter = DateFormatter()
    
    init(){
        df.calendar = Calendar(identifier: .gregorian)
        df.locale = Locale(identifier: "ja_JP")
        df.timeZone = TimeZone(identifier: "Asia/Tokyo")
        df.dateStyle = .short
        df.timeStyle = .none
    }
    /// 日付のみ表示用
    public func getDateDisplayFormatString(_ date:Date) -> String{
        df.dateFormat = "yyyy/MM/dd"
        return df.string(from: date)
    }
    
    /// 日付のみ表示用
    public func getConvertStringDate(_ str:String) -> Date{
        df.dateFormat = "yyyy/MM/dd"
        return df.date(from: str)!
    }
}
