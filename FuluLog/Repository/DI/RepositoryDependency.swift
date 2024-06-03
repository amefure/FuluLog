//
//  RepositoryDependency.swift
//  FuluLog
//
//  Created by t&a on 2024/05/31.
//

import UIKit

/// `Repository` & `Manager` クラスのDIクラス
class RepositoryDependency {
    
    public let userDefaultsRepository: UserDefaultsRepository
    public let realmDataBaseRepository: RealmDataBaseRepository

    //　シングルトンインスタンスをここで保持する
    static let sharedUserDefaultsRepository = UserDefaultsRepository()
    static let sharedRealmDataBaseRepository = RealmDataBaseRepository()
    
    init() {
        userDefaultsRepository = RepositoryDependency.sharedUserDefaultsRepository
        realmDataBaseRepository = RepositoryDependency.sharedRealmDataBaseRepository
    }
}

