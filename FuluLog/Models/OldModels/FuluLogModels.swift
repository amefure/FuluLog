//
//  FuluLogModels.swift
//  FuluLog
//
//  Created by t&a on 2022/09/10.
//

import Foundation


struct FuluLog: Identifiable,Codable,Equatable {

    var id = UUID()             // 一意の値
    var productName:String      // 商品名
    var amount:Int              // 金額情報
    var municipality:String = ""// 自治体
    var url:String = ""         // URL
    var memo:String = ""        // メモ
    var request:Bool = false    // ワンストップ申請
    var time:String = ""        // 日付
}


struct UserDonationInfo:Identifiable, Codable,Equatable {
    var id = UUID()             // 一意の値
    var year:String             // 年
    var limitAmount:Int         // 上限金額

}
// MARK: -

class AllFuluLog:ObservableObject{
    
    // MARK: - プロパティ
    @Published var allData:[FuluLog] = []  // 全情報
    @Published var donationLimit:[UserDonationInfo] = [] // 年ごとの寄付金額の上限配列
    @Published var allFavoriteData:[FuluLog] = []  // お気に入り全情報
    
    init(){
        self.setAllData()
        self.setAllDonationLimit()
        self.setAllFavoriteData()
    }
    
    // MARK: - プロパティセットメソッド
    func setAllData(){
        let f = FileController()
        self.allData = f.loadJson()
    }
    func setAllDonationLimit(){
        let f = FileController()
        self.donationLimit = f.loadDonationLimitJson()
    }
    func setAllFavoriteData(){
        let f = FileController()
        self.allFavoriteData = f.loadFavoriteJson()
    }

}

