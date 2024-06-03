//
//  RealmDataBaseViewModel.swift
//  FuluLog
//
//  Created by t&a on 2023/03/17.
//

import UIKit
import RealmSwift


class RealmDataBaseViewModel: ObservableObject {
    
    static let shared = RealmDataBaseViewModel()
    
    @Published var records: [FuluLogRecord] = []
    @Published var favoriteRecords: [FavoriteFuluLogRecord] = []
    @Published var userDonationInfoList: [UserDonationInfoRecord] = []
    
    private let repository: RealmDataBaseRepository
    
    init(repositoryDependency: RepositoryDependency = RepositoryDependency()) {
        repository = repositoryDependency.realmDataBaseRepository
        // 初回起動時にデータをセット
        allReadSetData()
    }
    
    public func allReadSetData() {
        readAllRecord()
        favorite_readAllRecord()
        donation_readAllRecord()
    }
    
    public func readAllRecord() {
        records.removeAll()
        let result = repository.readAllRecord()
        records = Array(result).reversed().sorted(by: {$0.time > $1.time})
    }

    public func favorite_readAllRecord() {
        favoriteRecords.removeAll()
        let result = repository.favorite_readAllRecord()
        favoriteRecords = Array(result).reversed().sorted(by: {$0.time > $1.time})
    }

    public func donation_readAllRecord() {
        userDonationInfoList.removeAll()
        let result = repository.donation_readAllRecord()
        userDonationInfoList = Array(result).reversed().sorted(by: { $0.year > $1.year })
    }
    
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
        repository.createRecord(
            productName: productName,
            amount: amount,
            municipality: municipality,
            url: url,
            memo: memo,
            time: time
        )
        readAllRecord()
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
        repository.updateRecord(
            id: id,
            productName: productName,
            amount: amount,
            municipality: municipality,
            url: url,
            request: request,
            memo: memo,
            time: time
        )
        readAllRecord()
    }
    
    // Delete
    public func deleteRecord(id: UUID) {
        repository.deleteRecord(id: id)
        readAllRecord()
    }
    
    
    // MARK: - FavoriteFuluLogRecord
    // Create
    public func favorite_createRecord(
        productName: String,
        amount: Int,
        municipality: String,
        url: String,
        memo: String,
        time: Date
    ){
        repository.favorite_createRecord(
            productName: productName,
            amount: amount,
            municipality: municipality,
            url: url,
            memo: memo,
            time: time
        )
        favorite_readAllRecord()
    }
    
    // MARK: - Update
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
        repository.favorite_updateRecord(
            id: id,
            productName: productName,
            amount: amount,
            municipality: municipality,
            url: url,
            request: request,
            memo: memo,
            time: time
        )
        favorite_readAllRecord()
    }
    
    // MARK: - Delete
    public func favorite_deleteRecord(id: UUID) {
        repository.favorite_deleteRecord(id: id)
        favorite_readAllRecord()
    }
    
    
    // MARK: - UserDonationInfoRecord
    // Create
    public func donation_createRecord(year: String,limitAmount: Int) {
        repository.donation_createRecord(year: year, limitAmount: limitAmount)
        donation_readAllRecord()
    }
    // Update
    public func donation_updateRecord(id: UUID, year: String, limitAmount: Int){
        repository.donation_updateRecord(id: id, year: year, limitAmount: limitAmount)
        donation_readAllRecord()
    }
    
    public func realmAllReset() {
        repository.deleteAllTable()
        allReadSetData()
    }
}
