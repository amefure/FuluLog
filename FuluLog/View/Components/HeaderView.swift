//
//  HeaderView.swift
//  FuluLog
//
//  Created by t&a on 2022/09/13.
//

import SwiftUI

struct HeaderView: View {
    
    // MARK: - ViewModels
    private let deviceSize = DeviceSizeUtility()
    
    // Header parameters
    public var headerTitle = ""
    public var leadingIcon: String = ""
    public var trailingIcon: String  = ""
    public var leadingAction: () -> Void = {}
    public var trailingAction: () -> Void = {}

    
    var body: some View {
        
        HStack {
            
            if !leadingIcon.isEmpty {
                
                Button {
                    leadingAction()
                } label: {
                    Image(systemName: leadingIcon)
                        .font(.system(size: 18))
                }.padding(.leading, 5)
                    .frame(width: 50)
            } else if !trailingIcon.isEmpty {
                Spacer()
                    .frame(width: 50)
            }
            
            Spacer()
            
            
            Text(headerTitle)
                .fontWeight(.bold)
                .font(.system(size: 18).monospaced())
            
            
            Spacer()

            if !trailingIcon.isEmpty {
                Button {
                    trailingAction()
                } label: {
                    Image(systemName: trailingIcon)
                        .font(.system(size: 18))
                }.padding(.trailing, 5)
                    .frame(width: 50)
            } else if !leadingIcon.isEmpty {
                Spacer()
                    .frame(width: 50)
            }
        }.padding()
            .frame(width: DeviceSizeUtility.deviceWidth, height: 50)
            .background(Asset.Colors.themaColor.swiftUIColor)
            .foregroundStyle(Asset.Colors.baseColor.swiftUIColor)
    }
    
}

