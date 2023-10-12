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
        .disabled(toolManager.activeItem == nil)
        
//        Menu(content: {
//            
//            Button("Widerrufen", systemImage: "arrow.uturn.backward", action: undo)
//                .disabled(!(undoManager?.canUndo ?? false))
//            
//            Button("Wiederholen", systemImage: "arrow.uturn.forward", action: redo)
//                .disabled(!(undoManager?.canRedo ?? false))
//            
//        }, label: {
//            Label(
//                "Widerrufen/Wiederholen",
//                systemImage: "arrow.uturn.backward.circle.badge.ellipsis"
//            )
//        })
        
    }
}
