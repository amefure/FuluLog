//
//  DisplayDateViewModel.swift
//  FuluLog
//
//  Created by t&a on 2023/03/16.
//

import UIKit

class DateFormatUtility {
    
    private let df = DateFormatter()
    private var c = Calendar(identifier: .gregorian)
        
    init(format: String = "yyyy-MM-dd") {
        df.dateFormat = format
        df.locale = Locale(identifier: "ja_JP")
        c.timeZone = TimeZone(identifier: "Asia/Tokyo")!
        df.calendar = c
        df.dateStyle = .short
        df.timeStyle = .none
    }
    
    /// 日付のみ表示用
    public func getDateDisplayFormatString(_ date:Date) -> String {
        df.dateFormat = "yyyy/MM/dd"
        return df.string(from: date)
    }
    
    /// 日付のみ表示用
    public func getConvertStringDate(_ str:String) -> Date {
        df.dateFormat = "yyyy/MM/dd"
        return df.date(from: str)!
    }
    
    public func nowFullDateString() -> String {
        let Str = df.string(from: Date())
        return String(Str)
    }
    
    public func nowYearString() -> String {
        let Str = df.string(from: Date()).prefix(4)
        return String(Str) // 2022 形式で年を返す
    }

}
