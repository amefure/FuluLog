//
//  UpdateFuluView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/11.
//

import SwiftUI

struct UpdateFuluLogView: View {
    
    // MARK: - ViewModels
    private let validation = ValidationUtility()
    private let displayDate = DateFormatUtility()
    
    @ObservedObject private var realmViewModel = RealmDataBaseViewModel.shared
    
    // MARK: - TextField
    @State private var productName = ""     // 商品名
    @State private var amount = -1             // 金額情報
    @State private var municipality = ""    // 自治体
    @State private var url = ""             // URL
    @State private var memo = ""            // メモ
    @State private var time: String = {             // 初期値に現在の日付
        let str = DateFormatUtility().getDateDisplayFormatString(Date())
        return str
    }()
    
    // MARK: - View
    @State private var isAlert = false     // 新規登録/更新処理を実行したアラート
    @State private var isFailedEntryAlert = false
    
    // MARK: - Receive
    public var item: FuluLogRecord
    
    @Binding var isModal: Bool
    
    public var isFavorite: Bool // Favoriteからの呼出かどうか
    
    private func validatuonInput() -> Bool {
        ValidationUtility.checkInputValidity(text: productName, amount: amount, urlStr: url)
    }
    
    private func resetInputData(){
        productName = ""     // 商品名
        amount = -1           // 金額情報
        municipality = ""    // 自治体
        url = ""             // URL
        memo = ""            // メモ
        time = ""
    }
    
    var body: some View {
        VStack {
            
            // ヘッダー
            HeaderView(
                headerTitle: "更新",
                trailingIcon: "checkmark",
                trailingAction: {
                    guard validatuonInput() else { return isFailedEntryAlert = true}
                    withAnimation(.linear(duration: 0.3)) {
                        
                        if isFavorite == false {
                            // MARK: - FuluLog
                            realmViewModel.updateRecord(
                                id: item.id,
                                productName: productName,
                                amount: amount,
                                municipality: municipality,
                                url: url,
                                request: item.request,
                                memo: memo,
                                time:displayDate.getConvertStringDate(time)
                            )
                            
                        } else {
                            // MARK: - Favorite
                            realmViewModel.favorite_updateRecord(
                                id: item.id,
                                productName: productName,
                                amount: amount,
                                municipality: municipality,
                                url: url,
                                request: item.request,
                                memo: memo,
                                time:displayDate.getConvertStringDate(time)
                            )
                        }
                        // parentUpdateItemFunction()
                        isAlert = true
                    }
                }
            )
            
            InputFuluLogView(
                productName: $productName,
                amount: $amount,
                municipality: $municipality,
                url: $url,
                memo: $memo,
                time: $time
            )
            
            Spacer()
            
        }.background(Asset.Colors.foundationColor.swiftUIColor)
            .onAppear { // 初期値格納用
                productName = item.productName     // 商品名
                amount = item.amount               // 金額情報
                municipality = item.municipality   // 自治体
                url = item.url                     // URL
                memo = item.memo                   // メモ
                time = item.timeString                 // 日付
            }.alert(Text("更新しました。"),isPresented: $isAlert){
                Button(action: {
                    resetInputData()
                    isModal = false
                }, label: {
                    Text("OK")
                })
            } message: {
                Text("")
            }.alert(Text("必要事項を入力し、有効なURLを入力してください。"), isPresented: $isFailedEntryAlert) {
                
            } message: {
                
            }
    }
}


