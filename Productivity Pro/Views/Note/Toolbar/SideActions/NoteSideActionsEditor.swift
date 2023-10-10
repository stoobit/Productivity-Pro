//
//  NoteSideActionDrawingModeDisabled.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.06.23.
//

import SwiftUI

extension NoteSideActions {
    @ViewBuilder func Editor() -> some View {
        @Bindable var subviewValue = subviewManager
        
        Button("Inspektor", systemImage: "paintbrush.pointed") { 
            toggleInspector()
        }
//        .disabled(toolManager.selectedItem == nil)
        
//        Menu(content: {
//            
//            Button("Widerrufen", systemImage: "arrow.uturn.backward.circle", action: undo)
//                .disabled(!(undoManager?.canUndo ?? false))
//            
//            Button("Wiederholen", systemImage: "arrow.uturn.forward.circle", action: redo)
//                .disabled(!(undoManager?.canRedo ?? false))
//            
//        }, label:  {
//            if undoManager?.canUndo ?? false {
//                Label("Widerrufen", systemImage: "arrow.uturn.backward")
//            } else if undoManager?.canRedo ?? false {
//                Label("Wiederholen", systemImage: "arrow.uturn.forward")
//            } else {
//                Label("Widerrufen", systemImage: "arrow.uturn.backward")
//            }
//        }) {
//            if undoManager?.canUndo ?? false {
//                undo()
//            } else if undoManager?.canRedo ?? false {
//                redo()
//            }
//        }
//        .disabled(
//            !(undoManager?.canUndo ?? false) &&
//            !(undoManager?.canRedo ?? false)
//        )
        
    }
}
