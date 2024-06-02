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

    //　シングルトンインスタンスをここで保持する
    static let sharedUserDefaultsRepository = UserDefaultsRepository()
    
    
    init() {
        userDefaultsRepository = RepositoryDependency.sharedUserDefaultsRepository
    }
}

