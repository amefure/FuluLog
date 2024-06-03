//
//  FuluLogRecord.swift
//  FuluLog
//
//  Created by t&a on 2024/06/02.
//

import UIKit
import RealmSwift

class FuluLogRecord: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id = UUID()             // 一意の値
    @Persisted var productName: String      // 商品名
    @Persisted var amount: Int              // 金額情報
    @Persisted var municipality: String     // 自治体
    @Persisted var url: String              // URL
    @Persisted var memo: String             // メモ
    @Persisted var request = false    // ワンストップ申請
    @Persisted var time: Date               // 日付
    
    var timeString: String{
        DateFormatUtility().getDateDisplayFormatString(time)
    }
}

class FavoriteFuluLogRecord: FuluLogRecord { }
