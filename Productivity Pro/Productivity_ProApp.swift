//
//  Productivity_ProApp.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 15.09.22.
//

import SwiftUI
import UniformTypeIdentifiers

@main
struct Productivity_ProApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(
            for: [
                Homework.self,
                ContentObject.self
            ],
            isAutosaveEnabled: true
        )
    }
}

extension UTType {
    static var pro: UTType {
        UTType(importedAs: "com.till-bruegmann.Productivity-Pro.pro")
    }
}

extension UTType {
    static var pronote: UTType {
        UTType(importedAs: "com.till-bruegmann.Productivity-Pro.pronote")
    }
}

extension UTType {
    static var probackup: UTType {
        UTType(importedAs: "com.till-bruegmann.Productivity-Pro.probackup")
    }
}
