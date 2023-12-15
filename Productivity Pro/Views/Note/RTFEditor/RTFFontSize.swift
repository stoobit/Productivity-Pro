//
//  RTFFontSize.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 14.12.23.
//

import SwiftUI

extension RTFEditorToolbar {
    @ViewBuilder func RTFFontSize() -> some View {
        Button(action: { showSize.toggle() }) {
            Label("Schriftgröße", systemImage: "textformat.size")
        }
    }
}
