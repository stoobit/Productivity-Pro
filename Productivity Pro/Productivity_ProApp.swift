//
//  Productivity_ProApp.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 15.09.22.
//

import SwiftUI

@main
struct Productivity_ProApp: App {
    var body: some Scene {
        WindowGroup(id: "main") {
            ContentViewContainer()
                .onAppear { onAppear() }
        }
        .modelContainer(
            for: [
                Homework.self,
                ContentObject.self,
                PPBookModel.self,
            ],
            isAutosaveEnabled: true,
            isUndoEnabled: false
        )
    }

    func onAppear() {
        UIView
            .appearance(
                whenContainedInInstancesOf: [UIAlertController.self]
            )
            .tintColor = UIColor.main
    }
}
