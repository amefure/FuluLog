//
//  EntryFuluLogView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/10.
//

import SwiftUI
import RealmSwift

struct EntryFuluLogView: View {
    
    // MARK: - ViewModels
    private let realmDataBase = RealmDataBaseViewModel()
    private let userDefaults = UserDefaultsManager()
    private let dateFormatUtility = DateFormatUtility()
    
    @ObservedResults(FuluLogRecord.self) var allFuluLogRecords
    
    // MARK: - TextField
    @State private var productName = ""     // 商品名
    @State private var amount = -1          // 金額情報
    @State private var municipality = ""    // 自治体
    @State private var url = ""             // URL
    @State private var memo = ""            // メモ
    @State private var time = {             // 初期値に現在の日付の文字列 yyyy/MM/dd
        let str = DateFormatUtility().getDateDisplayFormatString(Date())
        return str
    }()
    
    // MARK: - View
    @State private var isSuccessAlert = false
    @State private var isFavoriteAlert = false
    @State private var isFailedEntryAlert = false
    @State private var isLimitAlert = false
    
    @Binding var isModal: Bool             // Favoriteからの呼び出しで利用
    @State public var isFavorite = false  // Favoriteからの呼び出しかどうか
    
    // MARK: - Method
    private func checkLimitCountData() -> Bool{
        if allFuluLogRecords.count < userDefaults.getRecordLimitKey() {
            // 現在の要素数 < 上限数
            isLimitAlert = false
            return true
        } else {
            // 現在の要素数 = 上限数
            isLimitAlert = true
            return false
        }
    }
    
    /// true → 問題なし
    private func validatuonInput() -> Bool {
        ValidationUtility.checkInputValidity(text: productName, amount: amount, urlStr: url)
    }
    
    private func resetInputData() {
        productName = ""     // 商品名
        amount = -1          // 金額情報
        municipality = ""    // 自治体
        url = ""             // URL
        memo = ""            // メモ
        time = ""
    }
    
    
    var body: some View {
        VStack(spacing:0) {
            
            // MARK: - Header
            HeaderView(
                headerTitle: !isFavorite ? "新規登録" : "お気に入り登録",
                trailingIcon: "checkmark",
                trailingAction: {
                    guard validatuonInput() else { return isFailedEntryAlert = true }
                    if isFavorite {
                        // お気に入りからの呼び出しの場合
                        withAnimation(.linear(duration: 0.3)){
                            realmDataBase.favorite_createRecord(
                                productName: productName,
                                amount: amount,
                                municipality: municipality,
                                url: url,
                                memo: memo,
                                time: dateFormatUtility.getConvertStringDate(time)
                            )
                            
                            isFavoriteAlert = true
                        }
                    } else {
                        // 新規登録処理
                        if checkLimitCountData(){
                            // 新規登録処理
                            realmDataBase.createRecord(
                                productName: productName,
                                amount: amount,
                                municipality: municipality,
                                url: url,
                                memo: memo,
                                time: dateFormatUtility.getConvertStringDate(time)
                            )
                        }
                        isSuccessAlert = true
                    }
                }
            )
            
            // MARK: - Input
            InputFuluLogView(
                productName: $productName,
                amount: $amount,
                municipality: $municipality,
                url: $url,
                memo: $memo,
                time: $time
            ).background(Asset.Colors.foundationColor.swiftUIColor)
            
            
            Spacer()
            
        }.background(Color.white)
            .alert(Text("お気に入りに登録しました。"), isPresented: $isFavoriteAlert) {
                Button {
                    resetInputData()
                    isModal = false
                } label: {
                    Text("OK")
                }
            } message: {
            }
            .alert(Text(isLimitAlert ? "上限に達しました..." : "寄付情報を登録しました。"), isPresented: $isSuccessAlert) {
                Button {
                    if !isLimitAlert {
                        resetInputData()
                        isModal = false
                    }
                } label: {
                    Text("OK")
                }
            } message: {
                Text(isLimitAlert ? "広告を視聴すると\n保存容量を増やすことができます。" : "")
            }
            .alert(Text("必要事項を入力し、有効なURLを入力してください。"), isPresented: $isFailedEntryAlert) {
               
            } message: {

            }
    }
}


