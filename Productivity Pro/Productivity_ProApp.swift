//
//  Productivity_ProApp.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 15.09.22.
//

import SwiftUI
import Glassfy
import UniformTypeIdentifiers

@main
struct Productivity_ProApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear() {
                    let key = "f1e473aa31b84eca8d4944ef486c8be8"
                    Glassfy.initialize(apiKey: key, watcherMode: false)
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
