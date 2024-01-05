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
                .onAppear { onAppear() }
                .onOpenURL(perform: { _ in

                })
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
        UIView.appearance(
            whenContainedInInstancesOf: [UIAlertController.self]
        ).tintColor = UIColor.main
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {}
