//
//  TransferConfigurationViewModel.swift
//  FuluLog
//
//  Created by t&a on 2023/03/27.
//

import UIKit

// Ver 2.1.1 → 3.0.0 

//class TransferConfigurationViewModel{
//    
//    // MARK: - Models
//    private let model = RealmDataBaseRepository()
//    
//    // MARK: - AllTransfer
//    public func jsonTransforRealmDB(){
//        transfer_FuluLogRecord()
//        transfer_FavoriteFuluLogRecord()
//        transfer_UserDonationInfoRecord()
//        transfer_RecordLimit()
//    }
//    
//    // MARK: - FuluLogRecord
//    private func transfer_FuluLogRecord() {
//        let allFule = AllFuluLog()
//        let displayDateVM = DateFormatUtility()
//        for item in allFule.allData {
//            let record = FuluLogRecord()
//            record.productName = item.productName   // 商品名
//            record.amount = item.amount             // 金額情報
//            record.municipality = item.municipality // 自治体
//            record.url = item.url                   // URL
//            record.memo = item.memo// メモ
//            record.request = item.request
//            record.time = displayDateVM.getConvertStringDate(item.time) // 日付
//            model.createRecord(record: record)
//        }
//    }
//    
//    // MARK: - FavoriteFuluLogRecord
//    private func transfer_FavoriteFuluLogRecord(){
//        let allFule = AllFuluLog()
//        let displayDateVM = DateFormatUtility()
//        for item in allFule.allFavoriteData {
//            let record = FavoriteFuluLogRecord()
//            record.productName = item.productName   // 商品名
//            record.amount = item.amount             // 金額情報
//            record.municipality = item.municipality // 自治体
//            record.url = item.url                   // URL
//            record.memo = item.memo// メモ
//            record.request = item.request
//            record.time = displayDateVM.getConvertStringDate(item.time) // 日付
//            model.favorite_createRecord(record: record)
//        }
//    }
//    
//    // MARK: - UserDonationInfoRecord
//    private func transfer_UserDonationInfoRecord(){
//        let allFule = AllFuluLog()
//        for item in allFule.donationLimit {
//            let record = UserDonationInfoRecord()
//            record.year = item.year
//            record.limitAmount = item.limitAmount
//            model.donation_createRecord(record: record)
//        }
//    }
//    
//    // MARK: - RecordLimit
//    private func transfer_RecordLimit(){
//        let limit = FileController().loadLimitTxt()
//        UserDefaultsManager().setRecordLimitKey(limit)
//    }
//}
//
