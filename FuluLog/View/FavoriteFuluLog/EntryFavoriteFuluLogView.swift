//
//  EntryFavoriteFuluLogView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/18.
//

import SwiftUI

//struct EntryFavoriteFuluLogView: View {
//    
//    // MARK: - ViewModels
//    private let validation = ValidationViewModel()
//    private let realmDataBase = RealmDataBaseViewModel()
//    private let userDefaults = UserDefaultsViewModel()
//    private let displayDate = DisplayDateViewModel()
//    
//    // MARK: - TextField
//    @State var productName:String = ""     // 商品名
//    @State var amount:Int = -1             // 金額情報
//    @State var municipality:String = ""    // 自治体
//    @State var url:String = ""             // URL
//    @State var memo:String = ""            // メモ
//    @State var time:String = {             // 初期値に現在の日付の文字列 yyyy/MM/dd
//        let str = DisplayDateViewModel().getDateDisplayFormatString(Date())
//        return str
//    }()
//    
//    // MARK: - View
//    @State var isAlert:Bool = false
//    @Binding var isModal:Bool
//    
//    // MARK: - Method
//    
//    // disable:Bool true→非アクティブ false→OK
//    private func validatuonInput() -> Bool{
//        validation.checkInputValidity(text: productName, amount: amount, urlStr: url)
//    }
//    
//    private func resetInputData(){
//        productName = ""     // 商品名
//        amount = -1           // 金額情報
//        municipality = ""    // 自治体
//        url = ""             // URL
//        memo = ""            // メモ
//        time = ""
//    }
//    var body: some View {
//        
//            VStack{
//                // MARK: - Header
//                HeaderView(headerTitle: "お気に入り登録")
//                
//                // MARK: - Input
//                InputFuluLogView(productName: $productName, amount: $amount, municipality: $municipality, url: $url, memo: $memo,time: $time)
//                
//                // MARK: - UpdateBtn
//                Button(action: {
//                    withAnimation(.linear(duration: 0.3)){
//                        
//                        realmDataBase.favorite_createRecord(productName: productName, amount: amount, municipality: municipality, url: url,memo: memo,time: displayDate.getConvertStringDate(time))
//                        resetInputData()
//                        isAlert = true
//                    }
//                }, label: {
//                    Text("登録")
//                }).padding() // ボタンパディング用
//                    .disabled(validatuonInput())
//                    .background(validatuonInput() ? Color(red: 0.8, green: 0.8, blue: 0.8) : Color("SubColor") )
//                    .foregroundColor(validatuonInput() ? Color.black : Color("ThemaColor"))
//                    .cornerRadius(5)
//                    .padding(5)
//                // MARK: - UpdateBtn
//                
//                Spacer()
//                
//            }
//            .background(Color("FoundationColor"))
//            .alert(isPresented: $isAlert){
//                Alert(title:Text("お気に入りに登録しました。"),
//                      message: Text(""),
//                      dismissButton: .default(Text("OK"),
//                                              action: {
//                    resetInputData()
//                    isModal = false
//                }))
//            }
//            
//        }
//    }
//    
//struct EntryFavoriteFuluLogView_Previews: PreviewProvider {
//    static var previews: some View {
//        EntryFavoriteFuluLogView(isModal: Binding.constant(false))
//    }
//}
