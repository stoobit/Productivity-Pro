//
//  NoteSideActionDrawingModeDisabled.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.06.23.
//

import SwiftUI

extension NoteToolbar {
    @ViewBuilder func UndoActions() -> some View {
        Group {
            if (undoDisabled && redoDisabled) || toolManager.pencilKit {
                Button("Widerrufen", systemImage: "arrow.uturn.backward") {}
                    .disabled(true)
            } else if undoDisabled && redoDisabled == false {
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
                    Label("Bearbeiten", systemImage: "arrow.uturn.backward")
                }
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
                    Label("Bearbeiten", systemImage: "arrow.uturn.backward")
                } primaryAction: {
                    undo()
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
        !(toolManager.activePage?.canUndo ?? false)
    }

    var redoDisabled: Bool {
        !(toolManager.activePage?.canRedo ?? false)
    }
}
