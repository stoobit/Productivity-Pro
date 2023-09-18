//
//  DocumentPickerView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct DocumentPickerView: View {
    
    @AppStorage("recenturls") var recents: [URL] = []
    @AppStorage("pinnedurls") var pinned: [URL] = []
    
    @State var document: Document = Document()
    @State var url: URL = URL(string: "https://www.stoobit.com")!
    @State var showDocument: Bool = false
    
    @State var toolManager: ToolManager = ToolManager()
    @State var subviewManager: SubviewManager = SubviewManager()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    DocumentCreationView(
                        toolManger: toolManager, subviewManager: subviewManager
                    )
                    
                    DocumentBrowsingView(
                        toolManger: toolManager, subviewManager: subviewManager
                    )
                }
                
                Section("Angepinnt") {
                    ForEach(pinned, id: \.self) { pin in
                        let title = pin.lastPathComponent.string.dropLast(4)
                        
                        Button(action: { openNote(with: pin) }) {
                            Label(title, systemImage: "pin")
                        }
                        .frame(height: 30)
                    }
                }
                
                Section("Letzte") {
                    ForEach(recents, id: \.self) { recent in
                        let title = recent.lastPathComponent.string.dropLast(4)
                        
                        Button(action: { openNote(with: recent) }) {
                            Label(title, systemImage: "clock.arrow.circlepath")
                        }
                        .frame(height: 30)
                    }
                }
            }
            .environment(\.defaultMinListRowHeight, 10)
            .navigationTitle("Notizen")
        }
        .fullScreenCover(isPresented: $showDocument) {
            NoteView(
                document: $document, url: $url,
                subviewManager: subviewManager, toolManager: toolManager
            )
        }
        
    }
    
    func openNote(with url: URL) {
        self.url = url
        getDocument()
        
        showDocument.toggle()
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
}

#Preview {
    DocumentPickerView()
}
