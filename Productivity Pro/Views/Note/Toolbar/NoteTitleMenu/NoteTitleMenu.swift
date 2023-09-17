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
    @Binding var document: Document
    @Binding var url: URL
    
    @Bindable var subviewManager: SubviewManager
    @Bindable var toolManager: ToolManager
    
    var body: some View {
        
        Button("Umbenennen", systemImage: "pencil", action: {
            subviewManager.renameView.toggle()
        })
        
        Button("Bewegen", systemImage: "folder", action: {
            subviewManager.moveView.toggle()
        })
        
        Section {
            
            Button(action: {
                toolManager.isCanvasEnabled = false
                sharePDF()
            }) {
                
                Label("Export as PDF", systemImage: "doc")
                
            }
            
            Button(action: {
                toolManager.isCanvasEnabled = false
                print()
            }) {
                Label("Print", systemImage: "printer")
            }
            
        }
        
        if hsc == .compact {
            Button(action: {
                toolManager.isCanvasEnabled = false
                UITabBar.appearance().isHidden = false
                subviewManager.overviewSheet.toggle()
            }) {
                Label("Overview", systemImage: "square.grid.2x2")
            }
        }
        
    }
}

