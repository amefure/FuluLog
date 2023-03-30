//
//  HeaderView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/13.
//

import SwiftUI

struct HeaderView: View {
    
    // MARK: - ViewModels
    private let deviceSize = DeviceSizeViewModel()
    
    // Header parameters
    public var headerTitle:String = ""
    public var leftImageName:String = ""
    public var rightImageName:String = ""
    public var parentLeftButtonFunction: () -> Void = {}
    public var parentRightButtonFunction: () -> Void  = {}
    
    
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
            
        }.padding().frame(width: deviceSize.deviceWidth, height:50)
            .background(Color("ThemaColor"))
            .foregroundColor(Color("BaseColor"))
    }
    
}

