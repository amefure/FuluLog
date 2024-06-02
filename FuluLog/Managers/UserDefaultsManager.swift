//
//  UserDefaultsManager.swift
//  FuluLog
//
//  Created by t&a on 2023/03/24.
//

import UIKit

class UserDefaultsManager {
    
    private let userDefaultsRepository: UserDefaultsRepository
    
    init(repositoryDependency: RepositoryDependency = RepositoryDependency()) {
        userDefaultsRepository = repositoryDependency.userDefaultsRepository
    }
    
    // デフォルト制限数
    private let defaultLimit: Int = 3
    private let addLimitNum: Int = 5
    
    public func setMigrationKey(_ version: Double) {
        userDefaultsRepository.setDoubleData(key: UserDefaultsKey.MIGRATION, value: version)
    }

    public func getMigrationKey() -> Double {
        userDefaultsRepository.getDoubleData(key: UserDefaultsKey.MIGRATION)
    }
    
    
    // 最終視聴日
    public func setLastAcquisitionDateKey(_ now: String) {
        userDefaultsRepository.setStringData(key: UserDefaultsKey.LAST_ACQUISITION_DATE, value: now)
    }

    public func getLastAcquisitionDateKey() -> String {
        userDefaultsRepository.getStringData(key: UserDefaultsKey.LAST_ACQUISITION_DATE)
    }
    
    // 容量制限数
    public func addRecordLimitKey() {
        let currentLimit = getRecordLimitKey()
        let updateLimit = currentLimit + addLimitNum
        setRecordLimitKey(updateLimit)
    }
    
    public func setRecordLimitKey(_ num: Int) {
        userDefaultsRepository.setIntData(key: UserDefaultsKey.RECORD_LIMIT, value: num)
    }

    public func getRecordLimitKey() -> Int {
        let limit = userDefaultsRepository.getIntData(key: UserDefaultsKey.RECORD_LIMIT)
        return limit == 0 ? defaultLimit : limit
    }
    
    // App Groups
    public func setCountKey(count:Int) {
        UserDefaults(suiteName: "group.com.ame.FuluLog")?.set(count, forKey: UserDefaultsKey.APP_GROUP_COUNT)
    }
}
