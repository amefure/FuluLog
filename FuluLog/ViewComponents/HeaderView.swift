//
//  HeaderView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/13.
//

import SwiftUI

struct HeaderView: View {
    var deviceWidth = DeviceSizeModel.deviceWidth
    
    // Header parameters
    var headerTitle:String
    var leftImageName:String = ""
    var rightImageName:String = ""
    var parentLeftButtonFunction: () -> Void = {}
    var parentRightButtonFunction: () -> Void  = {}
    
    
    var body: some View {
        HStack(){
            
            // MARK: - LeftButton 戻るボタンなど
            Button(action: {
                parentLeftButtonFunction()
            }, label: {
                HStack{ //"chevron.backward"
                    Image(systemName: leftImageName)
                        .padding(.top,8)
                        .font(.system(size:22))
                }
            })
            
            Spacer()
            
            // MARK: - Title
            Text(headerTitle)
            
            Spacer()
            
            // MARK: - RightButton　登録/更新/など
            Button(action: {
                parentRightButtonFunction()
            }, label: {
                Image(systemName: rightImageName)
                    .padding(.top,8)
                    .font(.system(size:22))
            })
            
        }.padding().frame(width: deviceWidth, height:50)
            .background(Color("ThemaColor"))
            .foregroundColor(Color("BaseColor"))
    }
    
}

