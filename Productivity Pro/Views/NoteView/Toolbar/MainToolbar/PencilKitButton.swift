//
//  PencilKitButton.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.12.23.
//

import SwiftUI

extension NoteMainToolbar {
    @ViewBuilder func PencilKitButton() -> some View {
        Button(action: {
            toolManager.pencilKit.toggle()
            toolManager.activeItem = nil

        }) {
            if toolManager.pencilKit {
                Image(systemName: "pencil.tip.crop.circle.fill")
            } else {
                Image(systemName: "pencil.tip.crop.circle")
            }
        }
    }
}
