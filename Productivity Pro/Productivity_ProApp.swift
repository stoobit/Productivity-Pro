//
//  Productivity_ProApp.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 15.09.22.
//

import SwiftData
import SwiftUI

@main
struct Productivity_ProApp: App {
    var body: some Scene {
        WindowGroup(id: "main") {
            ContentView()
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
