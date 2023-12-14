//
//  RTFColor.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 14.12.23.
//

import SwiftUI

extension RTFEditorToolbar {
    @ViewBuilder func RTFColor() -> some View {
        Button(action: { showColor.toggle() }) {
            Label("Farbe", systemImage: "paintpalette")
        }
    }
}
