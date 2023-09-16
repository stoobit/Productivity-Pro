//
//  DocumentBrowsingView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 12.09.23.
//

import SwiftUI

struct DocumentBrowsingView: View {
    
    @StateObject var toolManger: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    @State var isBrowsing: Bool = false
    @State var isDocument: Bool = false
    @State var isFailure: Bool = false
    
    @State var document: Document = Document()
    @State var url: URL = URL(string: "https://www.stoobit.com")!
    
    var body: some View {
        
        Button(action: { isBrowsing.toggle() }) {
            Label("Notiz öffnen", systemImage: "doc")
                .foregroundStyle(Color.accentColor)
        }
        .frame(height: 30)
        .fileImporter(
            isPresented: $isBrowsing,
            allowedContentTypes: [.pro],
            allowsMultipleSelection: false
        ) { 
            result in importFile(with: result)
        }
        .alert("Ein Fehler ist aufgetreten.", isPresented: $isFailure) {
            Button("Ok", role: .cancel) { isFailure = false }
        }
        .fullScreenCover(isPresented: $isDocument, onDismiss: {
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
    
    func getDocument() {
        do {
            
            if url.startAccessingSecurityScopedResource() {
                let data = try Data(contentsOf: url)
                let decryptedData = Data(
                    base64Encoded: data, options: .ignoreUnknownCharacters
                ) ?? Data()
                
                defer { url.stopAccessingSecurityScopedResource() }
                document = try JSONDecoder().decode(Document.self, from: decryptedData)
            }
            
        } catch {
            
        }
    }
    
    func importFile(with result: Result<[URL], any Error>) {
        switch result {
        case .success(let urls):
            
            if let document = urls.first {
                url = document
                getDocument()
                
                isDocument.toggle()
            } else {
                isFailure.toggle()
            }
            
        case .failure:
            isFailure.toggle()
        }
    }
    
}

#Preview {
    DocumentBrowsingView(toolManger: ToolManager(), subviewManager: SubviewManager())
}
