//
//  PencilKitButton.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.12.23.
//

import SwiftUI

extension NoteMainToolbar {
    @ViewBuilder func PencilKitButton() -> some View {
        Button(action: { toolManager.pencilKit.toggle() }) {
            Image(systemName: toolManager.pencilKit ? "pencil.tip.crop.circle.fill" : "pencil.tip.crop.circle"
            )
        }
    }
}
