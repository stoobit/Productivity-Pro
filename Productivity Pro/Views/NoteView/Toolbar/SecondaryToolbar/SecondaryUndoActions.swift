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
        toolManager.activePage?.modelContext?.undoManager?.undo()
        toolManager.update += 1
    }

    func redo() {
        toolManager.activePage?.modelContext?.undoManager?.redo()
        toolManager.update += 1
    }

    var undoDisabled: Bool {
        let manager = toolManager.activePage?.modelContext?.undoManager

        guard let canUndo = manager?.canUndo else {
            return true
        }

        return !canUndo
    }

    var redoDisabled: Bool {
        let manager = toolManager.activePage?.modelContext?.undoManager

        guard let canRedo = manager?.canRedo else {
            return true
        }

        return !canRedo
    }
}
