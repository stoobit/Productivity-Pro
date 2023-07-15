//
//  NoteSideActionDrawingModeDisabled.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.06.23.
//

import SwiftUI
 
extension NoteSideActionToolbar {
    @ViewBuilder func DrawingModeDisabled() -> some View {
        if subviewManager.isPresentationMode == false {
            
            if hsc == .regular {
                
                Button(action: { undo() }) {
                    Label("Undo", systemImage: "arrow.uturn.backward")
                }
                .disabled(!(undoManager?.canUndo ?? false))
                
                Button(action: { redo() }) {
                    Label("Redo", systemImage: "arrow.uturn.forward")
                }
                .disabled(!(undoManager?.canRedo ?? false))
                
            } else {
                Menu(content: {
                    
                    Button(action: { undo() }) {
                        Label("Undo", systemImage: "arrow.uturn.backward")
                    }
                    .disabled(!(undoManager?.canUndo ?? false))
                    
                    Button(action: { redo() }) {
                        Label("Redo", systemImage: "arrow.uturn.forward")
                    }
                    .disabled(!(undoManager?.canRedo ?? false))
                    
                }) {
                    Label("Undo/Redo", systemImage: "arrow.uturn.backward")
                }
                .disabled(
                    !(undoManager?.canUndo ?? false) && !(undoManager?.canRedo ?? false)
                )
            }
            
            Button(action: {
                toolManager.selectedItem = document.document.note.pages[
                    toolManager.selectedPage
                ].items.first(where: { $0.id == toolManager.selectedItem?.id })
                subviewManager.showStylePopover.toggle()
            }) {
                ZStack {
                    Text("Show Editor")
                        .frame(width: 0, height: 0)
                    
                    Image(systemName: "paintbrush")
                }
            }
            .keyboardShortcut("e", modifiers: [.command])
            .disabled(toolManager.selectedItem == nil)
            .popover(isPresented: $subviewManager.showStylePopover) {
                EditPageItemView(
                    hsc: hsc,
                    document: $document,
                    toolManager: toolManager,
                    subviewManager: subviewManager
                )
                .presentationCompactAdaptation(.popover)
                .presentationBackgroundInteraction(.enabled)
            }
            
        }
    }
}
