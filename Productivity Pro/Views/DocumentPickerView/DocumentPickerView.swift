//
//  DocumentPickerView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct DocumentPickerView: View {
    var body: some View {
        DocumentPickerViewController()
            .edgesIgnoringSafeArea(.top)
    }
}

struct DocumentPickerViewController: UIViewControllerRepresentable {
    
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
        return DocumentPickerDelegate()
    }
    
    class DocumentPickerDelegate: NSObject, UIDocumentBrowserViewControllerDelegate {
        
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
        
    }
    
}

#Preview {
    DocumentPickerView()
}
