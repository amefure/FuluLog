//
//  UserDefaultsRepository.swift
//  FuluLog
//
//  Created by t&a on 2024/05/31.
//

import UIKit

class UserDefaultsKey {
    
    static let MIGRATION = "migration"
    static let LAST_ACQUISITION_DATE = "LastAcquisitionDate"
    static let RECORD_LIMIT = "RecordLimit"
    static let APP_GROUP_COUNT = "count"
}

/// UserDefaultsの基底クラス
class UserDefaultsRepository {

    private let userDefaults = UserDefaults.standard

    /// Bool：保存
    public func setBoolData(key: String, isOn: Bool) {
        userDefaults.set(isOn, forKey: key)
    }

    /// Bool：取得
    public func getBoolData(key: String) -> Bool {
        return userDefaults.bool(forKey: key)
    }

    /// Int：保存
    public func setIntData(key: String, value: Int) {
        userDefaults.set(value, forKey: key)
    }

    /// Int：取得
    public func getIntData(key: String) -> Int {
        return userDefaults.integer(forKey: key)
    }
    
    /// Double：保存
    public func setDoubleData(key: String, value: Double) {
        userDefaults.set(value, forKey: key)
    }

    /// Double：取得
    public func getDoubleData(key: String) -> Double {
        return userDefaults.double(forKey: key)
    }

    /// String：保存
    public func setStringData(key: String, value: String) {
        userDefaults.set(value, forKey: key)
    }

    /// String：取得
    public func getStringData(key: String, initialValue: String = "") -> String {
        return userDefaults.string(forKey: key) ?? initialValue
    }
}
