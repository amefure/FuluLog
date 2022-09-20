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
    // フィルタリング用
    @Published var timeArray:[String] = [] // 保存されている全年情報 ["2022","2023"]
    @Published var donationLimit:[UserDonationInfo] = [] // 年ごとの寄付金額の上限配列
    @Published var allFavoriteData:[FuluLog] = []  // お気に入り全情報
    
    init(){
        self.setAllData()
        self.createTimeArray()
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
    // MARK: - プロパティセットメソッド
    
    // MARK: - メソッド
    // 寄付金上限リスト用
    func sumYearAmount(_ year:String) -> Int{
        var sum = 0

        let filterData = allData.filter({$0.time.prefix(4) == year })
        for data in filterData {
            sum += data.amount
        }
        return sum
    }
    
    // 登録制限
    func countAllData() -> Int{
        return self.allData.count
    }
    
    // timeArrayに保存されている全年情報を抽出した重複のない配列を構築
    func createTimeArray(){
        var array:[String] = ["all"]
        for item in allData {
            array.append(String(item.time.prefix(4)))
        }
        let timeSet = Set(array) // 重複値を除去
        self.timeArray = Array(timeSet).sorted().reversed()
    }
    // MARK: - メソッド
    
    // MARK: -　CRUD
    func removeData(_ item:FuluLog) {
        guard let index = allData.firstIndex(of:item) else { return }
        allData.remove(at: index)
    }
    func updateData(_ item:FuluLog,_ id:UUID){
        guard let index = allData.firstIndex(where: { $0.id == id }) else { return }
        self.allData[index] = item
    }
    // MARK: -　CRUD
  
    // MARK: - Donation CRUD
    func updateDonationLimit(_ item:UserDonationInfo,_ year:String){
        let f = FileController()
        guard let index = donationLimit.firstIndex(where: { $0.year == year }) else {
            // 今年未保存の場合 = 今年の年が無い場合
            // 新規データを保存処理
            f.saveDonationLimitJson(item)
            return
        }
        // 今年分保存済み = 今年の年がある場合
        // Update処理
        self.donationLimit[index] = item
        f.updateDonationLimitJson(self.donationLimit)
    }
    // MARK: - Donation CRUD
    
    // MARK: - Favorite CRUD
    func removeFavoriteData(_ item:FuluLog) {
        guard let index = allFavoriteData.firstIndex(of:item) else { return }
        allFavoriteData.remove(at: index)
    }
    func updateFavoriteData(_ item:FuluLog,_ id:UUID){
        guard let index = allFavoriteData.firstIndex(where: { $0.id == id }) else { return }
        self.allFavoriteData[index] = item
    }
    // MARK: - Favorite CRUD
    

}

