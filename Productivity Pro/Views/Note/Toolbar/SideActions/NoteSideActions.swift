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
            Button("Lesezeichen", systemImage: "bookmark") {  }
                .tint(Color.red)
            
            Button("Übersicht", systemImage: "square.grid.2x2") {  }
            
            Button("Teilen", systemImage: "square.and.arrow.up") {  }
        }
        
        ToolbarItemGroup(placement: .primaryAction) {
            Button("Undo", systemImage: "arrow.uturn.backward") {}
            Button("Inspektor", systemImage: "paintbrush.pointed") {}
            
            PageActions()
        }
        
    }
}

