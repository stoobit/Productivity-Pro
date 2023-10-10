//
//  NavigationTitleMenuView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.09.22.
//

import SwiftUI
import PDFKit
import PencilKit

struct NoteTitleMenu: View {
    @Environment(ToolManager.self) var toolManager
    var contentObject: ContentObject
    
    var body: some View {
        Section {
            Button(action: { contentObject.isPinned.toggle() }) {
                Label(
                    contentObject.isPinned ? "Pin entfernen" : "Anpinnen",
                    systemImage: contentObject.isPinned ? "pin.slash" : "pin"
                )
            }
        }
        
        Section {
            Button("Umbenennen", systemImage: "pencil", action: {
                
            })
            
            Button("Bewegen", systemImage: "folder", action: {
                
            })
        }
        
        Section {
            Button("Teilen", systemImage: "square.and.arrow.up") {
                
            }
            
            Button(action: {
                toolManager.isCanvasEnabled = false
                print()
            }) {
                Label("Drucken", systemImage: "printer")
            }
        }
    }
}

