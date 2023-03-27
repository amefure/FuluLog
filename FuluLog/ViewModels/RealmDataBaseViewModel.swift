//
//  RealmDataBaseViewModel.swift
//  FuluLog
//
//  Created by t&a on 2023/03/17.
//

import UIKit
import RealmSwift


class RealmDataBaseViewModel {
    // MARK: -  通知管理用RealmDBのCRUD処理ViewModel
    
    // MARK: - Models
    private let model = RealmDataBaseModel()
    
    // MARK: - Models
    public var allFuluRecord:Results<FuluLogRecord> {
        return model.readAllRecord()
    }
    
    // MARK: - Models
    public var allFavoriteFuluRecord:Results<FavoriteFuluLogRecord> {
        return model.favorite_readAllRecord()
    }
    
    // MARK: - Models
    public var allUserDonationInfoRecord:Results<UserDonationInfoRecord> {
        return model.donation_readAllRecord()
    }
    
    // MARK: - Models
    public var count:Int {
        return allFuluRecord.count
    }
    
    // MARK: - FuluLogRecord
    // Create
    public func createRecord(productName:String,amount:Int,municipality:String,url:String,memo:String,time:Date){
        let record = FuluLogRecord()
        record.productName = productName   // 商品名
        record.amount = amount             // 金額情報
        record.municipality = municipality // 自治体
        record.url = url                   // URL
        record.memo = memo                 // メモ
        record.time = time                 // 日付
        model.createRecord(record: record)
    }
    
    // Update
    public func updateRecord(id:UUID,productName:String,amount:Int,municipality:String,url:String,memo:String,request:Bool,time:Date){
        let newRecord = FuluLogRecord()
        newRecord.id = id
        newRecord.productName = productName   // 商品名
        newRecord.amount = amount             // 金額情報
        newRecord.municipality = municipality // 自治体
        newRecord.url = url                   // URL
        newRecord.memo = memo                 // メモ
        newRecord.request = request           // ワンストップ申請
        newRecord.time = time                 // 日付
        model.updateRecord(newRecord: newRecord)
    }
    
    // Delete
    public func deleteRecord(id:UUID){
        model.deleteRecord(id: id)
    }
    
    
    // MARK: - FavoriteFuluLogRecord
    // Create
    public func favorite_createRecord(productName:String,amount:Int,municipality:String,url:String,memo:String,time:Date){
        let record = FavoriteFuluLogRecord()
        record.productName = productName   // 商品名
        record.amount = amount             // 金額情報
        record.municipality = municipality // 自治体
        record.url = url                   // URL
        record.memo = memo                 // メモ
        record.time = time                 // 日付
        model.favorite_createRecord(record: record)
    }
    
    // MARK: - Update
    public func favorite_updateRecord(id:UUID,productName:String,amount:Int,municipality:String,url:String,memo:String,request:Bool,time:Date){
        let newRecord = FavoriteFuluLogRecord()
        newRecord.id = id
        newRecord.productName = productName   // 商品名
        newRecord.amount = amount             // 金額情報
        newRecord.municipality = municipality // 自治体
        newRecord.url = url                   // URL
        newRecord.memo = memo                 // メモ
        newRecord.request = request           // ワンストップ申請
        newRecord.time = time                 // 日付
        model.favorite_updateRecord(newRecord: newRecord)
    }
    

    
    // MARK: - Delete
    public func favorite_deleteRecord(id:UUID){
        model.favorite_deleteRecord(id: id)
    }
    
    
    // MARK: - UserDonationInfoRecord
    // Create
    public func donation_createRecord(year:String,limitAmount:Int){
        let record = UserDonationInfoRecord()
        record.year = year
        record.limitAmount = limitAmount
        model.donation_createRecord(record: record)
    }
    // Create
    public func donation_updateRecord(id:UUID,year:String,limitAmount:Int){
        let newRecord = UserDonationInfoRecord()
        newRecord.id = id
        newRecord.year = year
        newRecord.limitAmount = limitAmount
        model.donation_updateRecord(newRecord: newRecord)
    }
    
    
    // MARK: - Transfer
    public func jsonTransforRealmDB(){
        transfer_FuluLogRecord()
        transfer_FavoriteFuluLogRecord()
        transfer_UserDonationInfoRecord()
    }
    
    
    
    private func transfer_FuluLogRecord(){
        let allFule = AllFuluLog()
        let displayDateVM = DisplayDateViewModel()
        for item in allFule.allData {
            let record = FuluLogRecord()
            record.productName = item.productName   // 商品名
            record.amount = item.amount             // 金額情報
            record.municipality = item.municipality // 自治体
            record.url = item.url                   // URL
            record.memo = item.memo// メモ
            record.request = item.request
            record.time = displayDateVM.getConvertStringDate(item.time) // 日付
            model.createRecord(record: record)
        }
    }
    
    private func transfer_FavoriteFuluLogRecord(){
        let allFule = AllFuluLog()
        let displayDateVM = DisplayDateViewModel()
        for item in allFule.allFavoriteData {
            let record = FavoriteFuluLogRecord()
            record.productName = item.productName   // 商品名
            record.amount = item.amount             // 金額情報
            record.municipality = item.municipality // 自治体
            record.url = item.url                   // URL
            record.memo = item.memo// メモ
            record.request = item.request
            record.time = displayDateVM.getConvertStringDate(item.time) // 日付
            model.favorite_createRecord(record: record)
        }
    }
    
    private func transfer_UserDonationInfoRecord(){
        let allFule = AllFuluLog()
        for item in allFule.donationLimit {
            let record = UserDonationInfoRecord()
            record.year = item.year
            record.limitAmount = item.limitAmount
            model.donation_createRecord(record: record)
        }
    }
    // MARK: - Transfer

    public func realmAllReset(){
        model.deleteAllTable()
    }
    
}


