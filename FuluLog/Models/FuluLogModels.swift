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
    var municipality:String = ""   // 自治体
    var url:String = ""             // URL
    var memo:String = ""        // メモ
    var request:Bool = false    // ワンストップ申請
    var time:String = { // 初期値に現在の日付
        
        let df = DateFormatter()
        df.calendar = Calendar(identifier: .gregorian)
        df.locale = Locale(identifier: "ja_JP")
        df.timeZone = TimeZone(identifier: "Asia/Tokyo")
        df.dateStyle = .short
        df.timeStyle = .none
        return df.string(from: Date())

    }()
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

    init(){
        self.setAllData()
        self.createTimeArray()
        self.setAllDonationLimit()
    }
    
    // MARK: - メソッド
    // JSONファイルに格納されている全キャッシュ情報をプロパティにセット
    func setAllData(){
        let f = FileController()
        self.allData = f.loadJson()
    }
    
    // MARK: - DonationLimitView
    func setAllDonationLimit(){
        let f = FileController()
        self.donationLimit = f.loadDonationLimitJson()
    }
    
    func sumYearAmount(_ year:String) -> Int{
        var sum = 0

        let filterData = allData.filter({$0.time.prefix(4) == year })
        for data in filterData {
            sum += data.amount
        }
        return sum
    }
        
    // 編集されたデータを共有しているクラスのプロパティにupdate
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
    // MARK: - DonationLimitView
    
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
    
    // MARK: -　Data操作
    func removeData(_ item:FuluLog) {
        guard let index = allData.firstIndex(of:item) else { return }
        allData.remove(at: index)
    }
    // 編集されたデータを共有しているクラスのプロパティにupdate
    func updateData(_ item:FuluLog,_ id:UUID){
        guard let index = allData.firstIndex(where: { $0.id == id }) else { return }
        self.allData[index] = item
    }
    // MARK: -　Data操作
}

