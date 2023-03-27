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
    
    // DonationLimit
    
    public func addDonationLimitKey(){
        userDefaults.set(addLimitNum, forKey: "donationLimit")
    }

    public func getDonationLimitKey() -> Int{
        let limit = userDefaults.integer(forKey: "donationLimit")
        if limit == 0 {
            return defaultLimit
        }else{
            return limit
        }
    }
}
