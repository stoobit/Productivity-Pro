//
//  DocumentView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 15.09.22.
//

import SwiftUI

struct DocumentView: View {
    
    @AppStorage("afterUpdate 0.4.2")
    private var firstOpenAU: Bool = true
    
    @State var whatIsNew: Bool = false
    
    @Binding var document: ProductivityProDocument
    @StateObject var subviewManager: SubviewManager
    @StateObject var toolManager: ToolManager
    
    var url: URL
    
    var body: some View {
        ZStack {
            
            Color(UIColor.secondarySystemBackground)
                .ignoresSafeArea(edges: .bottom)
            
            if document.document.documentType == .note {
                
                NoteView(
                    document: $document,
                    subviewManager: subviewManager,
                    toolManager: toolManager, url: url
                )
                .edgesIgnoringSafeArea(.bottom)
                .sheet(isPresented: $whatIsNew) {
                    WhatIsNew(isPresented: $whatIsNew)
                }
                
            } else if document.document.documentType == .realityNote {
                
            } else {
                CreateDoc()
            }
            
        }
        .toolbarRole(.editor)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear {
            if firstOpenAU && document.document.documentType != .none {
                whatIsNew = true
                firstOpenAU = false
            }
        }
        
    }
    
    @ViewBuilder func CreateDoc() -> some View {
        Spacer()
            .sheet(isPresented: $subviewManager.createDocument, onDismiss: {
                if firstOpenAU {
                    whatIsNew = true
                    firstOpenAU = false
                }
            }) {
                NewDocumentView(
                    document: $document.document,
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
