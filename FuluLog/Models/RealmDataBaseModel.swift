//
//  RealmDataBaseModel.swift
//  FuluLog
//
//  Created by t&a on 2023/03/17.
//

import UIKit
import RealmSwift

class RealmDataBaseModel {
    //MARK: -  通知管理用RealmDBのCRUD処理モデル

    private let realm = try! Realm()
 
    // MARK: - FuluLogRecord
    // Create
    public func createRecord(record:FuluLogRecord){
        try! realm.write {
            realm.add(record)
        }
    }
    
    // Read
    public func readIdRecord(id:UUID) -> FuluLogRecord{
        return realm.objects(FuluLogRecord.self).where({$0.id == id}).first!
    }
    
    // Read
    public func readAllRecord() -> Results<FuluLogRecord>{
        return realm.objects(FuluLogRecord.self)
    }
    
    // Update
    public func updateRecord(newRecord:FuluLogRecord){
        try! realm.write {
            realm.add(newRecord,update:.modified)
        }
    }
    
    // Delete
    public func deleteRecord(id:UUID) {
        try! realm.write{
            let record = readIdRecord(id:id)
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
    public func  favorite_createRecord(record:FavoriteFuluLogRecord){
        try! realm.write {
            realm.add(record)
        }
    }
    
    // Read
    public func favorite_readIdRecord(id:UUID) -> FavoriteFuluLogRecord{
        return realm.objects(FavoriteFuluLogRecord.self).where({$0.id == id}).first!
    }
    
    // Read
    public func favorite_readAllRecord() -> Results<FavoriteFuluLogRecord>{
        return realm.objects(FavoriteFuluLogRecord.self)
    }
    
    // Update
    public func favorite_updateRecord(newRecord:FavoriteFuluLogRecord){
        try! realm.write {
            realm.add(newRecord,update:.modified)
        }
    }
    
    // Delete
    public func favorite_deleteRecord(id:UUID) {
        try! realm.write{
            let record = favorite_readIdRecord(id:id)
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
    public func  donation_createRecord(record:UserDonationInfoRecord){
        try! realm.write {
            realm.add(record)
        }
    }
    
    // Read
    public func donation_readIdRecord(id:UUID) -> UserDonationInfoRecord{
        return realm.objects(UserDonationInfoRecord.self).where({$0.id == id}).first!
    }
    // Read
    public func donation_readAllRecord() -> Results<UserDonationInfoRecord>{
        return realm.objects(UserDonationInfoRecord.self)
    }
    
    
    // Update
    public func donation_updateRecord(newRecord:UserDonationInfoRecord){
        try! realm.write {
            realm.add(newRecord,update:.modified)
        }
    }
    
    // Delete
    public func donation_deleteRecord(id:UUID) {
        try! realm.write{
            let record = donation_readIdRecord(id:id)
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
