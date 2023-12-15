//
//  RTFStyle.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 14.12.23.
//

import SwiftUI

extension RTFEditorToolbar {
    @ViewBuilder func RTFStyle() -> some View {
        ControlGroup(content: {
            Button(action: { context.isBold.toggle() }) {
                Label("Fett", systemImage: "bold")
            }
            
            Button(action: { context.isItalic.toggle() }) {
                Label("Kursiv", systemImage: "italic")
            }
            
            Button(action: { context.isUnderlined.toggle() }) {
                Label("Unterstrichen", systemImage: "underline")
            }
            
            Button(action: { context.isStrikethrough.toggle() }) {
                Label("Durchgestrichen", systemImage: "strikethrough")
            }
        }) {
            Label("Style", systemImage: "bold.italic.underline")
        }
        .controlGroupStyle(.compactMenu)
    }
}
