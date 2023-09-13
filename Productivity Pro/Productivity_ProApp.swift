//
//  Productivity_ProApp.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 15.09.22.
//

import SwiftUI

@main
struct Productivity_ProApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ app: UIApplication, open inputURL: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
          
        print(inputURL)
        return true
        
    }
}
