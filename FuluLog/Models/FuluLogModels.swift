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
    var municipality:String     // 自治体
    var url:String                 // URL
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

// -------------------------------------------------------------

class AllFuluLog:ObservableObject{
    
    // MARK: -
    @Published var allData:[FuluLog] = [] // 全情報

    init(){
        self.setAllData()
    }
    
    // MARK: - メソッド
    // JSONファイルに格納されている全キャッシュ情報をプロパティにセット
    func setAllData(){
        let f = FileController()
        self.allData = f.loadJson()
    }

    
    func removeData(_ item:FuluLog) {
        guard let index = allData.firstIndex(of:item) else { return }
        allData.remove(at: index)
    }
    // 編集されたデータを共有しているクラスのプロパティにupdate
    func updateData(_ item:FuluLog,_ id:UUID){
        guard let index = allData.firstIndex(where: { $0.id == id }) else { return }
        self.allData[index] = item
    }
}

