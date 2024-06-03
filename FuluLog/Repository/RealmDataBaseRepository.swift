//
//  RealmDataBaseRepository.swift
//  FuluLog
//
//  Created by t&a on 2023/03/17.
//

import UIKit
import RealmSwift

class RealmDataBaseRepository {
    //MARK: -  通知管理用RealmDBのCRUD処理モデル
    
    init() {
        let config = Realm.Configuration(schemaVersion: RealmConfig.MIGRATION_VERSION)
        Realm.Configuration.defaultConfiguration = config
        realm = try! Realm()
    }

    // MARK: - private property
    private let realm: Realm
 
    // MARK: - FuluLogRecord
    // Create
    public func createRecord(
        productName: String,
        amount: Int,
        municipality: String,
        url: String,
        memo: String,
        time: Date
    ) {
        try! realm.write {
            let record = FuluLogRecord()
            record.productName = productName   // 商品名
            record.amount = amount             // 金額情報
            record.municipality = municipality // 自治体
            record.url = url                   // URL
            record.memo = memo                 // メモ
            record.time = time                 // 日付
            realm.add(record)
        }
    }
    
    // Read
    private func readIdRecord(id: UUID) -> FuluLogRecord? {
        return realm.objects(FuluLogRecord.self).where({$0.id == id}).first
    }
    
    // Read
    public func readAllRecord() -> Results<FuluLogRecord>{
        let records = realm.objects(FuluLogRecord.self)
        // Deleteでクラッシュするため凍結させる
        return records.freeze().sorted(byKeyPath: "id", ascending: true)
    }
    
    // Update
    public func updateRecord(
        id: UUID,
        productName: String,
        amount: Int,
        municipality: String,
        url: String,
        request: Bool,
        memo: String,
        time: Date
    ){
        try! realm.write {
            let newRecord = FuluLogRecord()
            newRecord.id = id
            newRecord.productName = productName   // 商品名
            newRecord.amount = amount             // 金額情報
            newRecord.municipality = municipality // 自治体
            newRecord.url = url                   // URL
            newRecord.memo = memo                 // メモ
            newRecord.request = request           // ワンストップ申請
            newRecord.time = time                 // 日付
            realm.add(newRecord, update: .modified)
        }
    }
    
    // Delete
    public func deleteRecord(id:UUID) {
        try! realm.write{
            guard let record = readIdRecord(id: id) else { return}
            realm.delete(record)
        }
    }
    public func deleteAllRecord() {
        try! realm.write{
            let fuluLogTable = realm.objects(FuluLogRecord.self)
            realm.delete(fuluLogTable)
        }
    }
    
    // MARK: - FavoriteFuluLogRecord
    // Create
    public func favorite_createRecord(
        productName: String,
        amount: Int,
        municipality: String,
        url: String,
        memo: String,
        time: Date)
    {
        try! realm.write {
            let record = FavoriteFuluLogRecord()
            record.productName = productName   // 商品名
            record.amount = amount             // 金額情報
            record.municipality = municipality // 自治体
            record.url = url                   // URL
            record.memo = memo                 // メモ
            record.time = time                 // 日付
            realm.add(record)
        }
    }
    
    // Read
    public func favorite_readIdRecord(id:UUID) -> FavoriteFuluLogRecord? {
        return realm.objects(FavoriteFuluLogRecord.self).where({$0.id == id}).first
    }
    
    // Read
    public func favorite_readAllRecord() -> Results<FavoriteFuluLogRecord> {
        let records = realm.objects(FavoriteFuluLogRecord.self)
        // Deleteでクラッシュするため凍結させる
        return records.freeze().sorted(byKeyPath: "id", ascending: true)
    }
    
    // Update
    public func favorite_updateRecord(
        id: UUID,
        productName: String,
        amount: Int,
        municipality: String,
        url: String,
        request: Bool,
        memo: String,
        time: Date
    ){
        try! realm.write {
            let newRecord = FavoriteFuluLogRecord()
            newRecord.id = id
            newRecord.productName = productName   // 商品名
            newRecord.amount = amount             // 金額情報
            newRecord.municipality = municipality // 自治体
            newRecord.url = url                   // URL
            newRecord.memo = memo                 // メモ
            newRecord.request = request           // ワンストップ申請
            newRecord.time = time                 // 日付
            realm.add(newRecord,update:.modified)
        }
    }
    
    // Delete
    public func favorite_deleteRecord(id: UUID) {
        try! realm.write{
            guard let record = favorite_readIdRecord(id: id) else { return}
            realm.delete(record)
        }
    }
    
    public func favorite_deleteAllRecord() {
        try! realm.write{
            let favoriteTable = realm.objects(FavoriteFuluLogRecord.self)
            realm.delete(favoriteTable)
        }
    }
    
    // MARK: - UserDonationInfoRecord
    // Create
    public func donation_createRecord(year: String, limitAmount: Int) {
        try! realm.write {
            let record = UserDonationInfoRecord()
            record.year = year
            record.limitAmount = limitAmount
            realm.add(record)
        }
    }
    
    // Read
    private func donation_readIdRecord(id: UUID) -> UserDonationInfoRecord? {
        return realm.objects(UserDonationInfoRecord.self).where({$0.id == id}).first
    }
    // Read
    public func donation_readAllRecord() -> Results<UserDonationInfoRecord> {
        let records = realm.objects(UserDonationInfoRecord.self)
        // Deleteでクラッシュするため凍結させる
        return records.freeze().sorted(byKeyPath: "id", ascending: true)
    }
    
    
    // Update
    public func donation_updateRecord(id: UUID, year: String, limitAmount :Int) {
        try! realm.write {
            let newRecord = UserDonationInfoRecord()
            newRecord.id = id
            newRecord.year = year
            newRecord.limitAmount = limitAmount
            realm.add(newRecord, update:.modified)
        }
    }
    
    // Delete
    public func donation_deleteRecord(id: UUID) {
        try! realm.write{
            guard let record = donation_readIdRecord(id: id) else { return }
            realm.delete(record)
        }
    }
    
    public func donation_deleteAllRecord() {
        try! realm.write{
            let favoriteTable = realm.objects(UserDonationInfoRecord.self)
            realm.delete(favoriteTable)
        }
    }
    
    // MARK: -
    public func deleteAllTable(){
        try! realm.write{
            realm.deleteAll()
        }
    }
}
