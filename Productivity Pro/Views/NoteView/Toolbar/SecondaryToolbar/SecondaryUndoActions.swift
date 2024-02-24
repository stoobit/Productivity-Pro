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
            .disabled(undoDisabled)

            Button("Wiederholen", systemImage: "arrow.uturn.forward") {
                redo()
            }
            .disabled(redoDisabled)
        } label: {
            if undoDisabled == true && redoDisabled == false {
                Label("Bearbeiten", systemImage: "arrow.uturn.forward")
            } else {
                Label("Bearbeiten", systemImage: "arrow.uturn.backward")
            }
        } primaryAction: {
            if undoDisabled == true && redoDisabled == false {
                redo()
            } else {
                undo()
            }
        }
        .disabled(undoDisabled && redoDisabled)
    }

    func undo() {
        modelContext.undoManager?.undo()
        toolManager.activeItem?.width += 0.01
        toolManager.activeItem?.width -= 0.01
    }

    func redo() {
        modelContext.undoManager?.redo()
    }

    var undoDisabled: Bool {
        if modelContext.undoManager == nil {
            return true
        } else {
            return !modelContext.undoManager!.canUndo
        }
    }

    var redoDisabled: Bool {
        if modelContext.undoManager == nil {
            return true
        } else {
            return !modelContext.undoManager!.canRedo
        }
    }
}
