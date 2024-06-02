//
//  FuluLogRealmModel.swift
//  FuluLog
//
//  Created by t&a on 2023/03/17.
//

import UIKit
import RealmSwift

// ReplaceMent RealmSwift

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

class UserDonationInfoRecord: Object, ObjectKeyIdentifiable, Codable {
    @Persisted(primaryKey: true) var id = UUID()  // 一意の値
    @Persisted var year: String             // 年
    @Persisted var limitAmount: Int         // 上限金額

}

