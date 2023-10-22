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
                    subviewManager.addPage = true
                }) {
                    Label("Seite hinzufügen", systemImage: "doc.badge.plus")
                }
                
                Button(action: {
                    toolManager.isCanvasEnabled = false
                    subviewManager.importFile = true
                }) {
                    Label("Datei importieren", systemImage: "square.and.arrow.down")
                }
            
                Button(action: {
                    toolManager.isCanvasEnabled = false
                    subviewManager.scanDocument = true
                }) {
                    Label("Dokument scannen", systemImage: "doc.text.fill.viewfinder")
                }
            }
            
            Section {
                Button(action: {
                    toolManager.isCanvasEnabled = false
                    subviewManager.changePage = true
                }) {
                    Label("Vorlage ändern", systemImage: "grid")
                }
                .disabled(templateChangeDisabled())
                
                Button(role: .destructive, action: {
                    toolManager.isCanvasEnabled = false
                    subviewManager.deletePage = true
                }) {
                    Label("Seite löschen", systemImage: "trash")
                }
                .disabled(false)
            }
        }) {
            Label("Seite", systemImage: "doc.badge.ellipsis")
        }
    }
}
