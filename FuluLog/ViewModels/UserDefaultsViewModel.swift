//
//  UserDefaultsViewModel.swift
//  FuluLog
//
//  Created by t&a on 2023/03/24.
//

import UIKit

class UserDefaultsViewModel {
    
    private let userDefaults = UserDefaults.standard
    
    // デフォルト制限数
    private let defaultLimit:Int = 3
    private let addLimitNum:Int = 3
    
    public func setMigrationKey(verNum:Double){
        userDefaults.set(verNum, forKey: "migration")
    }

    public func getMigrationKey() -> Double{
       return userDefaults.double(forKey: "migration")
    }
    
    
    // LastAcquisitionDate
    public func setLastAcquisitionDateKey(now:String){
        userDefaults.set(now, forKey: "LastAcquisitionDate")
    }

    public func getLastAcquisitionDateKey() -> String{
        return userDefaults.string(forKey: "LastAcquisitionDate") ?? ""
    }
    
    // DonationLimit
    
    public func addRecordLimitKey(){
        let currentLimit = getRecordLimitKey()
        let updateLimit = currentLimit + addLimitNum
        userDefaults.set(updateLimit, forKey: "RecordLimit")
    }
    
    public func setRecordLimitKey(num:Int){
        userDefaults.set(num, forKey: "RecordLimit")
    }

    public func getRecordLimitKey() -> Int{
        let limit = userDefaults.integer(forKey: "RecordLimit")
        if limit == 0 {
            return defaultLimit
        }else{
            return limit
        }
    }
    
    // App Groups
    public func setCountKey(count:Int){
        UserDefaults(suiteName: "group.com.ame.FuluLog")?.set(count, forKey: "count")
    }
}
