//
//  Productivity_ProApp.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 15.09.22.
//

import SwiftUI
import TipKit

@main
struct Productivity_ProApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentViewContainer()
                .onAppear { onAppear() }
                .task {
                    try? Tips.resetDatastore()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        try? Tips.configure([
                            .displayFrequency(.immediate),
                            .datastoreLocation(.applicationDefault)
                        ])
                    }
                }
        }
        .modelContainer(
            for: [
                Homework.self,
                ContentObject.self,
                PPNoteModel.self,
                PPPageModel.self,
                PPItemModel.self
            ],
            isAutosaveEnabled: true,
            isUndoEnabled: true
        )
    }

    func onAppear() {
        UIView
            .appearance(whenContainedInInstancesOf: [UIAlertController.self])
            .tintColor = UIColor.main
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {}
