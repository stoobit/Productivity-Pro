//
//  DocumentView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 15.09.22.
//

import SwiftUI

struct DocumentView: View {
    
    @AppStorage("afterUpdate 0.2.0")
    private var firstOpenAU: Bool = true
    
    @State var whatIsNew: Bool = false
    
    @Binding var document: ProductivityProDocument
    @StateObject var subviewManager: SubviewManager
    @StateObject var toolManager: ToolManager
    
    var body: some View {
        ZStack {
            
            Color(UIColor.secondarySystemBackground).edgesIgnoringSafeArea(.all)
            
            if document.document.documentType == .note {
                
                NoteView(
                    document: $document,
                    subviewManager: subviewManager,
                    toolManager: toolManager
                )
                .edgesIgnoringSafeArea(.bottom)
                
            } else {
                CreateDoc()
            }
            
        }
        .toolbarRole(.editor)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .sheet(isPresented: $whatIsNew) {
            WhatIsNew(isPresented: $whatIsNew)
        }
        .onAppear {
            if firstOpenAU && document.document.documentType != .none {
                whatIsNew = true
                firstOpenAU = false
            }
        }
    }
    
    @ViewBuilder func CreateDoc() -> some View {
        Spacer()
            .sheet(isPresented: $subviewManager.isChooseDocType, onDismiss: {
                if firstOpenAU {
                    whatIsNew = true
                    firstOpenAU = false
                }
            }) {
                NewDocumentView(
                    document: $document.document, subviewManager: subviewManager
                )
            }
            .onAppear {
                subviewManager.isChooseDocType = true
            }
    }
}
