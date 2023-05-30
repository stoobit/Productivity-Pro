//
//  ContentView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 15.09.22.
//

import SwiftUI

struct ContentView: View {
    
    @Binding var document: Productivity_ProDocument
    @StateObject var subviewManager: SubviewManager
    @StateObject var toolManager: ToolManager
    
    var body: some View {
            DocumentView(
                document: $document,
                subviewManager: subviewManager,
                toolManager: toolManager
            )
            .disabled(toolManager.showProgress)
            .overlay {
                if toolManager.showProgress {
                    ProgressView("Processing...")
                        .progressViewStyle(.circular)
                        .tint(.accentColor)
                        .frame(width: 175, height: 100)
                        .background(.thickMaterial)
                        .cornerRadius(13, antialiased: true)
                }
            }
            .sheet(isPresented: $subviewManager.sharePDFSheet) {
                ShareSheet(
                    showProgress: $toolManager.showProgress,
                    subviewManager: subviewManager,
                    toolManager: toolManager,
                    document: $document,
                    type: .pdf
                )
            }
        
    }
}
