//
//  Productivity_ProApp.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 15.09.22.
//

import Mixpanel
import SwiftData
import SwiftUI

@main
struct Productivity_ProApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup(id: "main") {
            ContentViewContainer()
                .onChange(of: scenePhase) {
                    if scenePhase == .active {
                        #if DEBUG
                        #else
                        Mixpanel.mainInstance()
                            .track(event: "Opened App", properties: [:])
                        #endif
                    }
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

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        #if DEBUG
        #else
        Mixpanel.initialize(
            token: "a41902ce7adc3f661f894ea7bf893e47",
            trackAutomaticEvents: false
        )
        #endif

        return true
    }
}
