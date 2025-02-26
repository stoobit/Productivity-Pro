import SwiftUI

extension NoteToolbar {
    @ViewBuilder func UndoActions() -> some View {
        Group {
            if (undoDisabled && redoDisabled) || toolManager.pencilKit {
                Button("Undo", systemImage: "arrow.uturn.backward") {}
                    .disabled(true)
            } else if undoDisabled && redoDisabled == false {
                Menu {
                    Button("Undo", systemImage: "arrow.uturn.backward") {
                        undo()
                    }
                    .disabled(undoDisabled)

                    Button("Redo", systemImage: "arrow.uturn.forward") {
                        redo()
                    }
                    .disabled(redoDisabled)
                } label: {
                    Label("Edit", systemImage: "arrow.uturn.backward")
                }
            } else {
                Menu {
                    Button("Undo", systemImage: "arrow.uturn.backward") {
                        undo()
                    }
                    .disabled(undoDisabled)

                    Button("Redo", systemImage: "arrow.uturn.forward") {
                        redo()
                    }
                    .disabled(redoDisabled)
                } label: {
                    Label("Edit", systemImage: "arrow.uturn.backward")
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
