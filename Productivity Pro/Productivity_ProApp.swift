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
    var body: some Scene {
        WindowGroup(id: "main") {
            ContentViewContainer()
                .onAppear { onAppear() }
                .task {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        try? Tips.configure([
                            .displayFrequency(.immediate),
                            .datastoreLocation(.applicationDefault),
                        ])
                    }
                }
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
            .appearance(whenContainedInInstancesOf: [UIAlertController.self])
            .tintColor = UIColor.main
    }
}
