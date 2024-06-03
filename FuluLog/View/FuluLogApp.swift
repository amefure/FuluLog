//
//  FuluLogApp.swift
//  FuluLog
//
//  Created by t&a on 2022/09/10.
//

import SwiftUI
import GoogleMobileAds
import FirebaseCore

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        FirebaseApp.configure()
        return true
    }
    
}

@main
struct FuluLogApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
