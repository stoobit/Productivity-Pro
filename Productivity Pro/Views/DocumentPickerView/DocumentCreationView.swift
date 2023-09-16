//
//  DocumentCreationView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 13.09.23.
//

import SwiftUI

struct DocumentCreationView: View {
    
    @Environment(\.scenePhase) var scenePhase
    
    let timer = Timer
        .publish(every: 180, tolerance: 120, on: .main, in: .common)
        .autoconnect()
    
    @StateObject var toolManger: ToolManager
    @StateObject var subviewManager: SubviewManager
    
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
        .fullScreenCover(isPresented: $showDocument, onDismiss: { saveDocument()
            document = Document()
            url = URL(string: "https://www.stoobit.com")!
        }) {
            
            NoteView(
                document: $document,
                url: $url,
                subviewManager: subviewManager,
                toolManager: toolManger
            )
            .onReceive(timer) { input in
                saveDocument()
            }
            .onReceive(NotificationCenter.default.publisher(
                for: UIApplication.willTerminateNotification)
            ) { output in
                saveDocument()
            }
            .onChange(of: scenePhase) {
                saveDocument()
            }
            
        }
        
    }
    
    func saveDocument() {
        do {
            if url.startAccessingSecurityScopedResource() {
                let data = try JSONEncoder().encode(document)
                let encryptedData = data.base64EncodedData()
                
                try encryptedData.write(
                    to: url, options: Data.WritingOptions.noFileProtection
                )
                
                url.stopAccessingSecurityScopedResource()
            }
            
        } catch { }
    }
    
}

#Preview {
    DocumentPickerView()
}
