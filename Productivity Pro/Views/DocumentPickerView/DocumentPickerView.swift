//
//  DocumentPickerView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct DocumentPickerView: View {
    
    @State var url: URL?
    @State var showNote: Bool = false
    
    var body: some View {
        DocumentPickerViewController(url: $url)
            .edgesIgnoringSafeArea(.top)
            .onChange(of: url) {
                if url != nil { showNote = true }
            }
            .fullScreenCover(isPresented: $showNote, onDismiss: { url = nil }) {
                
            }
    }
}

struct DocumentPickerViewController: UIViewControllerRepresentable {
    
    @Binding var url: URL?
    
    func makeUIViewController(context: Context) -> some UIDocumentBrowserViewController {
        
        let browser = UIDocumentBrowserViewController(forOpening: [.pro])
        
        browser.delegate = context.coordinator
        browser.shouldShowFileExtensions = false
        browser.allowsDocumentCreation = true
        browser.localizedCreateDocumentActionTitle = "Neue Notiz"
        
        return browser
        
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> DocumentPickerDelegate {
        return DocumentPickerDelegate(url: $url)
    }
    
    
    class DocumentPickerDelegate: NSObject, UIDocumentBrowserViewControllerDelegate {
        
        @Binding var url: URL?
        init(url: Binding<URL?>) {
            _url = url
        }
        
        func documentBrowser(_ controller: UIDocumentBrowserViewController, didRequestDocumentCreationWithHandler importHandler: @escaping (URL?, UIDocumentBrowserViewController.ImportMode) -> Void) {
               
               let doc = UIDocument()
               let url = doc.fileURL
               
               // Create a new document in a temporary location.
            doc.save(to: url, for: .forCreating) { (saveSuccess) in
                
                // Make sure the document saved successfully.
                guard saveSuccess else {
                
                    
                    // Cancel document creation.
                    importHandler(nil, .none)
                    return
                }
                
                // Close the document.
                doc.close(completionHandler: { (closeSuccess) in
                    
                    // Make sure the document closed successfully.
                    guard closeSuccess else {
                        
                        // Cancel document creation.
                        importHandler(nil, .none)
                        return
                    }
                    
                    // Pass the document's temporary URL to the import handler.
                    importHandler(url, .move)
                })
            }
        }
        
        func documentBrowser(
            _ controller: UIDocumentBrowserViewController, didPickDocumentsAt documentURLs: [URL]
        ) {
            url = documentURLs.first
        }
    }
    
}

#Preview {
    DocumentPickerView()
}
