//
//  FileController.swift
//  FuluLog
//
//  Created by t&a on 2022/09/10.
//

import Foundation


// 請求金額を蓄積するためのFileController
class FileController {
    
    // Documents内で操作するJSONファイル名
    private let FileName:String = "Fululog.json"
    // Documents内で追加できるロケーション数を格納
    private let txtName:String = "LimitNum.txt"
    // デフォルト制限数
    private let defaultLimit:String = "3"
    
    // 寄付上限金額用ファイル
    private let donationLimitName:String = "DonationLimit.json"
    
    // お気に入り用ファイル
    private let favoriteName:String = "FavoriteFuluLog.json"
    
    // 保存ファイルへのURLを作成 file::Documents/fileName
    private func docURL(_ fileName:String) -> URL? {
        let fileManager = FileManager.default
        do {
            // Docmentsフォルダ
            let docsUrl = try fileManager.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false)
            // URLを構築
            let url = docsUrl.appendingPathComponent(fileName)
            
            return url
        } catch {
            return nil
        }
    }
    // 操作するJsonファイルがあるかどうか
    private  func hasFile (_ fileName:String) -> Bool{
        let str =  NSHomeDirectory() + "/Documents/" + fileName
        if FileManager.default.fileExists(atPath: str) {
            return true
        }else{
            return false
        }
    }
    
    // 念の為数値かチェック
    private func numCheck (_ str:String) -> Bool{
        guard Int(str) != nil else {
            return false // 文字列の場合
        }
        return true // 数値の場合
    }
    
    // MARK: - FuluLog
    // ファイル削除処理
    func clearFile() {
        guard let url = docURL(FileName) else {
            return
        }
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
        }
    }
    
    
    // JSONデータを読み込んで[構造体]にする
    func loadJson() -> [FuluLog] {
        guard let url = docURL(FileName) else {
            return []
        }
        if hasFile(FileName) {
            // JSONファイルが存在する場合
            let jsonData = try! String(contentsOf: url).data(using: .utf8)!
            let dataArray = try! JSONDecoder().decode([FuluLog].self, from: jsonData)
            return dataArray
        }else{
            // JSONファイルが存在しない場合
            return []
        }
    }
    // MARK: - FuluLog
    
    // MARK: - LimitNum.txt
    func loadLimitTxt() -> Int {
        
        guard let url = docURL(txtName) else {
            return Int(defaultLimit)!
        }
        
        do {
            if hasFile(txtName) {
                let currentLimit = try String(contentsOf: url, encoding: .utf8)
                
                if numCheck(currentLimit) {
                    return Int(currentLimit)!
                }else{
                    return Int(defaultLimit)!
                }
                
            }else{
                try defaultLimit.write(to: url,atomically: true,encoding: .utf8)
                return Int(defaultLimit)!
            }
            
        } catch{
            // JSONファイルが存在しない場合
            return Int(defaultLimit)!
        }
        
    }
    
    // JSONデータを読み込んで[構造体]にする
    func loadDonationLimitJson() -> [UserDonationInfo] {
        guard let url = docURL(donationLimitName) else {
            return []
        }
        if hasFile(donationLimitName) {
            // JSONファイルが存在する場合
           
            let jsonData = try! String(contentsOf: url).data(using: .utf8)!
           
            let dataArray = try! JSONDecoder().decode([UserDonationInfo].self, from: jsonData)
            return dataArray
        }else{
            // JSONファイルが存在しない場合
            return []
        }
    }
    // MARK: - DonationLimit
    
    
    // JSONデータを読み込んで[構造体]にする
    func loadFavoriteJson() -> [FuluLog] {
        guard let url = docURL(favoriteName) else {
            return []
        }
        if hasFile(favoriteName) {
            // JSONファイルが存在する場合
            let jsonData = try! String(contentsOf: url).data(using: .utf8)!
            let dataArray = try! JSONDecoder().decode([FuluLog].self, from: jsonData)
            return dataArray
        }else{
            // JSONファイルが存在しない場合
            return []
        }
    }
    
    // MARK: - FavoriteFuluLog
}

