//
//  NoteSidePageActions.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 18.09.23.
//

import SwiftUI

extension NoteSecondaryToolbar {
    @ViewBuilder func PageActions() -> some View {
        
        Menu(content: {
            Section {
                Button(action: {
                    toolManager.isCanvasEnabled = false
                    subviewManager.addPageSettingsSheet = true
                }) {
                    Label("Seite hinzufügen", systemImage: "doc.badge.plus")
                }
            
                Button(action: {
                    toolManager.isCanvasEnabled = false
                    subviewManager.showScanDoc.toggle()
                }) {
                    Label("Dokument scannen", systemImage: "doc.text.fill.viewfinder")
                }
                
                Button(action: {
                    toolManager.isCanvasEnabled = false
                    subviewManager.showImportFile.toggle()
                }) {
                    Label("PDF importieren", systemImage: "folder")
                }
            }
            
            Section {
                Button(action: {
                    toolManager.isCanvasEnabled = false
                    subviewManager.changeTemplate.toggle()
                }) {
                    Label("Vorlage ändern", systemImage: "grid")
                }
                .disabled(templateChangeDisabled())
                
                Button(role: .destructive, action: {
                    toolManager.isCanvasEnabled = false
                    subviewManager.isDeletePageAlert.toggle()
                }) {
                    Label("Seite löschen", systemImage: "trash")
                }
                .disabled(false)
            }
        }) {
            Label("Seite", systemImage: "doc.badge.ellipsis")
        }
//        .modifier(
//            AddPDFPageHelper(
//                document: $document,
//                toolManager: toolManager,
//                subviewManager: subviewManager
//            )
//        )
        
    }
}
