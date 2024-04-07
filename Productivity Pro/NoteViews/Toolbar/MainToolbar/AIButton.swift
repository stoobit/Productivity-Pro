//
//  AIButton.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 07.04.24.
//

import SwiftUI

extension NoteMainToolbar {
    @ViewBuilder func AIButton() -> some View {
        Button(action: { subviewManager.showAI.toggle() }) {
            Label("AI", systemImage: "brain")
        }
    }
}
