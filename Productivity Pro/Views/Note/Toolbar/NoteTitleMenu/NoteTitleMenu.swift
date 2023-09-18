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
    @Environment(\.horizontalSizeClass) var hsc
    @AppStorage("pinnedurls") var pinned: [URL] = []
    
    @Binding var document: Document
    @Binding var url: URL
    
    @Bindable var subviewManager: SubviewManager
    @Bindable var toolManager: ToolManager
    
    var body: some View {
        Section {
            Button("Umbenennen", systemImage: "pencil", action: {
                subviewManager.renameView.toggle()
            })
            
            Button("Bewegen", systemImage: "folder", action: {
                subviewManager.moveView.toggle()
            })
        }
        
        Button(action: togglePin) {
            Label(
                pinned.contains(url) ? "Pin entfernen" : "Anpinnen",
                systemImage: pinned.contains(url) ? "pin.slash" : "pin"
            )
        }
        
        Section {
            Button(action: {
                toolManager.isCanvasEnabled = false
                sharePDF()
            }) {
                Label("Als PDF exportieren", systemImage: "doc")
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

