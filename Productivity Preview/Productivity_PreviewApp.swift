//
//  Productivity_PreviewApp.swift
//  Productivity Preview
//
//  Created by Till Brügmann on 04.01.24.
//

import SwiftUI

@main
struct Productivity_PreviewApp: App {
    var body: some Scene {
        DocumentGroup(viewing: ProNoteFile.self) { file in
            ContentView()
        }
    }
}
