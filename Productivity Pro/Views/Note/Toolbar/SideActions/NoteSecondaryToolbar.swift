//
//  TopToolbar.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.09.22.
//

import SwiftUI

struct NoteSecondaryToolbar: ToolbarContent {
    @Environment(\.undoManager) var undoManager
    @Environment(\.horizontalSizeClass) var hsc
    
    @Environment(ToolManager.self) var toolManager
    @Environment(SubviewManager.self) var subviewManager
    
    @State var showCalculator: Bool = false
    
    var contentObject: ContentObject
    var body: some ToolbarContent {
        @Bindable var subviewValue = subviewManager
        
        ToolbarItemGroup(placement: .topBarLeading) {
            Button("Lesezeichen", systemImage: "bookmark") { 
                
            }
            .tint(Color.red)
            
            Button("Übersicht", systemImage: "square.grid.2x2") { 
                subviewManager.overview.toggle()
            }
            
            Button("Teilen", systemImage: "square.and.arrow.up") {
                toolManager.selectedContentObject = contentObject
                subviewManager.shareView.toggle()
            }
        }
        
        ToolbarItemGroup(placement: .primaryAction) {
            MainAction()
            Button("Undo", systemImage: "arrow.uturn.backward") {}
            PageActions()
        }
        
    }
}

