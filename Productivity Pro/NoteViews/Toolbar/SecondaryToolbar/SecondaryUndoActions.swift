//
//  NoteSideActionDrawingModeDisabled.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.06.23.
//

import SwiftUI

extension NoteSecondaryToolbar {
    @ViewBuilder func UndoActions() -> some View {
        Group {
            if (undoDisabled && redoDisabled) || toolManager.pencilKit {
                Button("Widerrufen", systemImage: "arrow.uturn.backward") {}
                    .disabled(true)
            } else {
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
                    if undoDisabled == false {
                        Label("Bearbeiten", systemImage: "arrow.uturn.backward")
                    } else {
                        Label("Bearbeiten", systemImage: "arrow.uturn.forward")
                    }
                } primaryAction: {
                    if undoDisabled == false {
                        undo()
                    } else {
                        redo()
                    }
                }
            }
        }
        .id(toolManager.update)
        .onChange(of: toolManager.pencilKit) {
            toolManager.activePage?.reset()
        }
    }

    func undo() {
        toolManager.activePage?.undo(toolManager: toolManager)
        toolManager.update += 1
    }

    func redo() {
        toolManager.activePage?.redo(toolManager: toolManager)
        toolManager.update += 1
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
