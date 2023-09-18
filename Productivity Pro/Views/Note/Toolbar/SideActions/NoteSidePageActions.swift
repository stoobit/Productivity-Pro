//
//  NoteSidePageActions.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 18.09.23.
//

import SwiftUI

extension NoteSideActions {
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
                    subviewManager.changeTemplate.toggle()
                }) {
                    Label("Vorlage ändern", systemImage: "doc.badge.gearshape")
                }
                .disabled(templateChangeDisabled())
            }
            
            Section {
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
            
            Button(role: .destructive, action: {
                toolManager.isCanvasEnabled = false
                subviewManager.isDeletePageAlert.toggle()
            }) {
                Label("Seite löschen", systemImage: "trash")
            }
            .disabled(
                document.note.pages.count == 1
            )
            
        }) {
            Label("Seiten bearbeiten", systemImage: "doc.badge.ellipsis")
        }
        .modifier(
            AddPDFPageHelper(
                document: $document,
                toolManager: toolManager,
                subviewManager: subviewManager
            )
        )
        
    }
}
