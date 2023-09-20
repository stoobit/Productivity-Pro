//
//  DocumentCreationView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 13.09.23.
//

import SwiftUI

struct DocumentCreationView: View {
    
    var toolManger: ToolManager
    @Bindable var subviewManager: SubviewManager
    
    @State var document: Document = Document()
    @State var url: URL = URL(string: "https://www.stoobit.com")!
    
    @State var showCreationView: Bool = false
    @State var showDocument: Bool = false

    var body: some View {
        Button(action: { showCreationView.toggle() }) {
            Label("Notiz erstellen", systemImage: "plus")
                .foregroundStyle(Color.accentColor)
        }
        .frame(height: 30)
        .sheet(isPresented: $showCreationView, onDismiss: {
            if document.documentType != .none {
                showDocument.toggle()
            } else {
                url = URL(string: "https://www.stoobit.com")!
            }
        }) {
            NewDocumentView(
                isPresented: $showCreationView,
                showDocument: $showDocument,
                document: $document,
                url: $url,
                subviewManager: subviewManager,
                toolManager: toolManger
            )
        }
        .fullScreenCover(isPresented: $showDocument, onDismiss: {
            document = Document()
            url = URL(string: "https://www.stoobit.com")!
        }) {
            
            NoteView(
                document: $document,
                url: $url,
                subviewManager: subviewManager,
                toolManager: toolManger
            )
            
        }
        
    }
}

#Preview {
    DocumentPickerView()
}
