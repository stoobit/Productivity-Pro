//
//  NoteSideActionDrawingModeDisabled.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.06.23.
//

import SwiftUI

extension NoteSecondaryToolbar {
    @ViewBuilder func UndoActions() -> some View {
        if undoDisabled && redoDisabled {
            Button("Widerrufen", systemImage: "arrow.uturn.backward") {}
                .disabled(true)
        } else {
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
    }

    func undo() {
        toolManager.activePage?.undo()
    }

    func redo() {
        toolManager.activePage?.redo()
    }

    var undoDisabled: Bool {
        if let undo = toolManager.activePage?.canUndo {
            return !undo
        }
        
        return true
    }

    var redoDisabled: Bool {
        if let redo = toolManager.activePage?.canRedo {
            return !redo
        }
        
        return true
    }
}
