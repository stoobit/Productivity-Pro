//
//  Productivity_ProApp.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 15.09.22.
//

import SwiftData
import SwiftUI
import Analytics

@main
struct Application: App {
    @Environment(\.scenePhase) private var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    @State private var analytics = Analytics(key: Analytics.key())
    
    var body: some Scene {
        WindowGroup(id: "main") {
            ContentView()
                .environment(analytics)
                .onChange(of: scenePhase) {
                    analytics.flush()
                }
        }
        .modelContainer(
            for: [
                Homework.self,
                ContentObject.self,
            ],
            isAutosaveEnabled: true,
            isUndoEnabled: false
        )
    }
}
