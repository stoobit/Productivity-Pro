//
//  DocumentBrowsingView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 12.09.23.
//

import SwiftUI

struct DocumentBrowsingView: View {
    
    @Environment(\.scenePhase) var scenePhase
    
    let timer = Timer
        .publish(every: 180, tolerance: 120, on: .main, in: .common)
        .autoconnect()
    
    @State var isBrowsing: Bool = false
    @State var isDocument: Bool = false
    @State var isFailure: Bool = false
    
    @State var document: Document = Document()
    @State var url: URL = URL(string: "https://www.stoobit.com")!
    
    var body: some View {
        
        Button(action: { isBrowsing.toggle() }) {
            Label("Notizen durchsuchen", systemImage: "magnifyingglass")
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
        .fullScreenCover(isPresented: $isDocument, onDismiss: { saveDocument() }) {
            DocumentView(document: $document, url: $url)
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
            
            let data = try JSONEncoder().encode(document)
            let encryptedData = data.base64EncodedData()
            
            try encryptedData.write(
                to: url, options: Data.WritingOptions.noFileProtection
            )
            
        } catch { }
    }
    
    func getDocument() {
        do {
            
            let data = try Data(contentsOf: url)
            let decryptedData = Data(
                base64Encoded: data, options: .ignoreUnknownCharacters
            ) ?? Data()
            
            document = try JSONDecoder().decode(Document.self, from: decryptedData)
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
    DocumentBrowsingView()
}
