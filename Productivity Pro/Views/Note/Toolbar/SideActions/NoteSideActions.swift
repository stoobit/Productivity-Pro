//
//  TopToolbar.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.09.22.
//

import SwiftUI

struct NoteSideActions: ToolbarContent {
    @Environment(\.undoManager) var undoManager
    @Environment(\.horizontalSizeClass) var hsc
    
    @Environment(ToolManager.self) var toolManager
    @Environment(SubviewManager.self) var subviewManager
    
    var contentObject: ContentObject
    var body: some ToolbarContent {
        @Bindable var subviewValue = subviewManager
        
        ToolbarItemGroup(placement: .topBarLeading) {
            PageActions()
        }
        
        ToolbarItemGroup(placement: .primaryAction) {
            
            Section {
                Button("Inspektor", systemImage: "paintbrush.pointed") {}
                    .popover(isPresented: $subviewValue.showCalculator) {
                        CalculatorView()
                            .frame(width: 300, height: 460)
                            .presentationCompactAdaptation(.popover)
                            .modifier(LockScreen())
                    }
            }
            
            Section {
                Button("Undo", systemImage: "arrow.uturn.backward") {}
            }
        }
        
    }
}

