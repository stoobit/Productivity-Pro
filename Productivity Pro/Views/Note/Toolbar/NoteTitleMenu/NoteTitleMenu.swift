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
    @Environment(SubviewManager.self) var subviewManager
    
    var contentObject: ContentObject
    
    var body: some View {
        Section {
            Button("Umbenennen", systemImage: "pencil") {
                subviewManager.renameView.toggle()
            }
            
            Button(action: { contentObject.isPinned.toggle() }) {
                Label(
                    contentObject.isPinned ? "Pin entfernen" : "Anpinnen",
                    systemImage: contentObject.isPinned ? "pin.slash" : "pin"
                )
            }
        }
        
        Section {
            Button("Drucken", systemImage: "printer") {
                
            }
        }
    }
}

