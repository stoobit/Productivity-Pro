//
//  DocumentView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 15.09.22.
//

import SwiftUI

struct DocumentTypeContainerView: View {
    
    @Binding var document: Document
    
    @StateObject var subviewManager: SubviewManager
    @StateObject var toolManager: ToolManager
    
    var url: URL
    
    var body: some View {
        ZStack {
            
            Color(UIColor.secondarySystemBackground)
                .ignoresSafeArea(edges: .bottom)
            
            if document.documentType == .note {
                
                NoteView(
                    document: $document,
                    subviewManager: subviewManager,
                    toolManager: toolManager, url: url
                )
                .edgesIgnoringSafeArea(.bottom)
                
            } else if document.documentType == .realityNote {
                
            } else {
                CreateDoc()
            }
            
        }
        .toolbarRole(.editor)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        
    }
    
    @ViewBuilder func CreateDoc() -> some View {
        Spacer()
            .sheet(isPresented: $subviewManager.createDocument) {
                NewDocumentView(
                    document: $document,
                    subviewManager: subviewManager,
                    toolManager: toolManager
                )
                .interactiveDismissDisabled()
            }
            .onAppear {
                subviewManager.createDocument = true
            }
    }
    
}
