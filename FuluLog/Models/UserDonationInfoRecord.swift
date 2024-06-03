//
//  UserDonationInfoRecord.swift
//  FuluLog
//
//  Created by t&a on 2024/06/02.
//

import UIKit
import RealmSwift

class UserDonationInfoRecord: Object, ObjectKeyIdentifiable, Codable {
    @Persisted(primaryKey: true) var id = UUID()  // 一意の値
    @Persisted var year: String             // 年
    @Persisted var limitAmount: Int         // 上限金額
}
