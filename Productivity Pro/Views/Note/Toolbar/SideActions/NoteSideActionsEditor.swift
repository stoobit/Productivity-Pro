//
//  NoteSideActionDrawingModeDisabled.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.06.23.
//

import SwiftUI

extension NoteSideActions {
    @ViewBuilder func Editor() -> some View {
        
        if hsc == .regular {
            
            Button("Widerrufen", systemImage: "arrow.uturn.backward", action: undo)
                .disabled(!(undoManager?.canUndo ?? false))
            
            Button("Wiederholen", systemImage: "arrow.uturn.forward", action: redo)
                .disabled(!(undoManager?.canRedo ?? false))
            
        } else {
            Menu(content: {
                
                Button("Widerrufen", systemImage: "arrow.uturn.backward", action: undo)
                    .disabled(!(undoManager?.canUndo ?? false))
                
                Button("Wiederholen", systemImage: "arrow.uturn.forward", action: redo)
                    .disabled(!(undoManager?.canRedo ?? false))
                
            }) {
                Label("Widerrufen/Wiederholen", systemImage: "arrow.uturn.backward")
            }
            .disabled(!(undoManager?.canUndo ?? false) && !(undoManager?.canRedo ?? false))
        }
        
        Button("", systemImage: "paintbrush", action: showItemEditor)
            .disabled(toolManager.selectedItem == nil)
            .popover(isPresented: $subviewManager.showStylePopover) {
                EditPageItemView(
                    hsc: hsc,
                    document: $document,
                    toolManager: toolManager,
                    subviewManager: subviewManager
                )
                .presentationDetents([.medium, .large])
                .presentationBackgroundInteraction(.enabled)
            }
        
    }
}
