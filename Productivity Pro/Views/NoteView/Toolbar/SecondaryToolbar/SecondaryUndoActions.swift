//
//  NoteSideActionDrawingModeDisabled.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.06.23.
//

import SwiftUI

extension NoteSecondaryToolbar {
    @ViewBuilder func UndoActions() -> some View {
        Menu {
            Button("Widerrufen", systemImage: "arrow.uturn.backward") {
                undo()
            }

            Button("Wiederholen", systemImage: "arrow.uturn.forward") {
                redo()
            }
        } label: {
            Label("Bearbeiten", systemImage: "arrow.uturn.backward")
        } primaryAction: {
            undo()
        }
    }

    func undo() {
        
    }

    func redo() {
        
    }
}
