//
//  TopToolbar.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.09.22.
//

import SwiftUI

struct NoteToolbar: ToolbarContent {
    @Environment(\.dismiss) var dismiss
    @Environment(\.horizontalSizeClass) var hsc
    @Environment(ToolManager.self) var toolManager
    @Environment(SubviewManager.self) var subviewManager
    
    @AppStorage("defaultFont") var defaultFont: String = "Avenir Next"
    @AppStorage("defaultFontSize") var defaultFontSize: Double = 12
    @AppStorage("createdNotes") var createdNotes: Int = 0
    
    @Bindable var contentObject: ContentObject
    var size: CGSize
    
    var body: some ToolbarContent {
        @Bindable var subviewValue = subviewManager
        
        ToolbarItemGroup(placement: .topBarLeading) {
            Button("Zurück", systemImage: "chevron.left") {
                contentObject.note?.recent = toolManager.activePage
                
                toolManager.activeItem = nil
                toolManager.pencilKit = false
                
                for page in contentObject.note!.pages! {
                    page.store = []
                }
                
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
            
            PageActions()
        }
        
        ToolbarItemGroup(placement: .primaryAction) {
            PencilAction()
            InsertAction()
            InspectorAction()
            UndoActions()
            
            Menu(content: {
                NoteTitleMenu(contentObject: contentObject)
            }) {
                Image(systemName: "ellipsis.circle")
            }
        }
    }
}
