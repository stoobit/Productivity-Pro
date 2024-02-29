//
//  TopToolbar.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.09.22.
//

import SwiftUI

struct NoteSecondaryToolbar: ToolbarContent {
    @Environment(\.dismiss) var dismiss
    @Environment(\.horizontalSizeClass) var hsc
    
    @Environment(ToolManager.self) var toolManager
    @Environment(SubviewManager.self) var subviewManager
    
    @Bindable var contentObject: ContentObject
    
    var body: some ToolbarContent {
        @Bindable var subviewValue = subviewManager
        
        ToolbarItemGroup(placement: .topBarLeading) {
            Button("Zurück", systemImage: "chevron.left") {
                toolManager.activeItem = nil
                toolManager.activePage = nil
                toolManager.pencilKit = false
                
                dismiss()
            }
            
            Button("Lesezeichen", systemImage: toolManager.activePage?.isBookmarked == true ? "bookmark.fill" : "bookmark") {
                toolManager.activePage?.isBookmarked.toggle()
            }
            .tint(Color.red)
            
            Button("Übersicht", systemImage: "square.grid.2x2") {
                toolManager.pencilKit = false
                toolManager.activeItem = nil
                
                subviewManager.overview.toggle()
            }
            
            Menu(content: {
                ShareMenu(object: contentObject)
            }) {
                Label("Teilen", systemImage: "square.and.arrow.up")
            }
        }
        
        ToolbarItemGroup(placement: .primaryAction) {
            InspectorAction()
            UndoActions()
            PageActions()
        }
    }
}
