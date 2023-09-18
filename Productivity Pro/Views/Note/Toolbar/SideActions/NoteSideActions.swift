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
    
    @Binding var document: Document
    @Binding var url: URL
    
    @Bindable var toolManager: ToolManager
    @Bindable var subviewManager: SubviewManager
    
    let dismissAction: () -> Void
    
    var body: some ToolbarContent {
        
        ToolbarItemGroup(placement: .topBarLeading) {
            Button(action: dismissAction) {
                Image(systemName: "chevron.down")
            }
            .fontWeight(.bold)
            
            Button(action: toggleOverview) {
                Image(systemName: "square.grid.2x2")
            }
        }
        
        ToolbarItemGroup(placement: .primaryAction) {
            Editor()
            PageActions()
        }
        
    }
}

