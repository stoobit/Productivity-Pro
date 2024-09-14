//
//  SecondaryPencilAction.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 14.09.24.
//

import SwiftUI

extension NoteToolbar {
    @ViewBuilder func PencilAction() -> some View {
        Button(action: {
            toolManager.pencilKit.toggle()
            toolManager.activeItem = nil
            
        }) {
            if toolManager.pencilKit {
                Label("Apple Pencil", systemImage: "pencil.tip.crop.circle.fill")
            } else {
                Label("Apple Pencil", systemImage: "pencil.tip.crop.circle")
            }
        }
    }
}
