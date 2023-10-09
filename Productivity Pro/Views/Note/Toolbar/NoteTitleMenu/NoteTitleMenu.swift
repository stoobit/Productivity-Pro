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
    var contentObject: ContentObject
    
    var body: some View {
        Section {
            Button("Umbenennen", systemImage: "pencil", action: {
                
            })
            
            Button("Bewegen", systemImage: "folder", action: {
                
            })
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

