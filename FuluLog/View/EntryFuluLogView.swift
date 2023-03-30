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
    private let validation = ValidationViewModel()
    private let realmDataBase = RealmDataBaseViewModel()
    private let userDefaults = UserDefaultsViewModel()
    private let displayDate = DisplayDateViewModel()
    
    @ObservedResults(FuluLogRecord.self) var allFuluLogRecords
    
    // MARK: - TextField
    @State var productName:String = ""     // 商品名
    @State var amount:Int = -1             // 金額情報
    @State var municipality:String = ""    // 自治体
    @State var url:String = ""             // URL
    @State var memo:String = ""            // メモ
    @State var time:String = {             // 初期値に現在の日付の文字列 yyyy/MM/dd
        let str = DisplayDateViewModel().getDateDisplayFormatString(Date())
        return str
    }()
    
    // MARK: - View
    @State var isAlert:Bool = false
    @State var isFavoriteAlert:Bool = false
    @State var isLimitAlert:Bool = false // 上限に達した場合のアラート
    
    @Binding var isModal:Bool          // Favoriteからの呼び出し
    @State var isFavorite:Bool = false // Favoriteからの呼び出し
    
    // MARK: - Method
    private func checkLimitCountData() -> Bool{
        if allFuluLogRecords.count < userDefaults.getRecordLimitKey() {
            // 現在の要素数 < 上限数
            isLimitAlert = false
            return true
        }else{
            // 現在の要素数 = 上限数
            isLimitAlert = true
            return false
        }
    }
    
    // disable:Bool true→非アクティブ false→OK
    private func validatuonInput() -> Bool{
        validation.checkInputValidity(text: productName, amount: amount, urlStr: url)
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
        VStack(spacing:0){
            
            // MARK: - Header
            HeaderView(headerTitle: !isFavorite ? "ふるログ" : "お気に入り")
            
            // MARK: - Input
            InputFuluLogView(productName: $productName, amount: $amount, municipality: $municipality, url: $url, memo: $memo,time: $time)
                .background(Color("FoundationColor"))
            
            // MARK: - EntryBtn
            Button(action: {
                
                if isFavorite{
                    // お気に入りからの呼び出しの場合
                    withAnimation(.linear(duration: 0.3)){
                        realmDataBase.favorite_createRecord(productName: productName, amount: amount, municipality: municipality, url: url,memo: memo,time: displayDate.getConvertStringDate(time))
                        
                        isFavoriteAlert = true
                    }
                }else{
                    // 新規登録処理
                    if checkLimitCountData(){
                        // 新規登録処理
                        realmDataBase.createRecord(productName: productName, amount: amount, municipality: municipality, url: url,memo: memo,time: displayDate.getConvertStringDate(time))
                    }
                    isAlert = true
                }
                
            }, label: {
                Text("登録")
            })
            .padding()
            .disabled(validatuonInput())
            .background(validatuonInput() ? Color(red: 0.8, green: 0.8, blue: 0.8) : Color("SubColor") )
            .foregroundColor(validatuonInput() ? Color.black : Color("ThemaColor"))
            .cornerRadius(5)
            .padding(5)
            // MARK: - EntryBtn
            
            
            Spacer()
            
        }
        .background(Color.white)
        .alert(Text("お気に入りに登録しました。"), isPresented: $isFavoriteAlert) {
            Button {
                resetInputData()
                isModal = false
            } label: {
                Text("OK")
            }
        } message: {
        }
        .alert(Text(isLimitAlert ? "上限に達しました..." : "寄付情報を登録しました。"),isPresented: $isAlert){
            
            Button(action: {
                if !isLimitAlert {
                    resetInputData()
                }
            }, label: {
                Text("OK")
            })
        } message: {
            Text(isLimitAlert ? "広告を視聴すると\n保存容量を増やすことができます。" : "")
        }
    }
}


