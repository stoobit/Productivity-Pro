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
        }
        
//        ToolbarItemGroup(placement: .primaryAction) {
//            
//            EditingToolbar()
//            
//            if subviewManager.isPresentationMode == false {
//                Menu(content: {
//                    Section {
//                        Button(action: {
//                            toolManager.isCanvasEnabled = false
//                            subviewManager.addPageSettingsSheet = true
//                        }) {
//                            Label("Add Page", systemImage: "doc.badge.plus")
//                        }
//                        
//                        Button(action: {
//                            toolManager.isCanvasEnabled = false
//                            subviewManager.changeTemplate.toggle()
//                        }) {
//                            Label("Change Template", systemImage: "doc.badge.gearshape")
//                        }
//                        .disabled(templateChangeDisabled())
//                        
//                    }
//                    
//                    Section {
//                        Button(action: {
//                            toolManager.isCanvasEnabled = false
//                            subviewManager.showScanDoc.toggle()
//                        }) {
//                            Label("Scan Document", systemImage: "doc.text.fill.viewfinder")
//                        }
//                        
//                        Button(action: {
//                            toolManager.isCanvasEnabled = false
//                            subviewManager.showImportFile.toggle()
//                        }) {
//                            Label("Import PDF", systemImage: "folder")
//                        }
//                    }
//                    
//                    Button(role: .destructive, action: {
//                        toolManager.isCanvasEnabled = false
//                        subviewManager.isDeletePageAlert.toggle()
//                    }) {
//                        Label("Delete Page", systemImage: "trash")
//                    }
//                    .disabled(
//                        document.note.pages.count == 1
//                    )
//                    
//                }) {
//                    Label("Page Actions", systemImage: "doc.badge.ellipsis")
//                }
//                .modifier(
//                    AddPDFPageHelper(
//                        document: $document,
//                        toolManager: toolManager,
//                        subviewManager: subviewManager
//                    )
//                )
//            }
//        }
    }
    
}

