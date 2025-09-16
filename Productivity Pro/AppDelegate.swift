//
//  AppDelegate.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 16.09.25.
//

import UIKit
import Analytics

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any ]? = nil) -> Bool {
        
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
               if granted {
                   Task { @MainActor in
                       UIApplication.shared.registerForRemoteNotifications()
                   }
               }
           }
           
           return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
     
        let analytics = Analytics(key: Analytics.key())
        analytics.registerForPushNotifications(with: deviceToken)
    }
}
