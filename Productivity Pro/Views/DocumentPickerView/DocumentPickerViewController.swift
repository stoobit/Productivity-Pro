//
//  BrowsingPickerView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 12.09.23.
//

import SwiftUI

struct DocumentPickerViewController: UIViewControllerRepresentable {
    
    @Binding var url: URL?
    let type: UIDocumentPickerType
    
    let dismiss: () -> Void
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(
            forOpeningContentTypes: type == .browse ? [.pro] : [.folder]
        )
        
        picker.delegate = context.coordinator
        picker.allowsMultipleSelection = false
        picker.directoryURL = .downloadsDirectory
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(url: $url) { dismiss() }
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        @Binding var url: URL?
        var dismiss: () -> Void
        
        init(url: Binding<URL?>, dismiss: @escaping () -> Void) {
            _url = url
            self.dismiss = dismiss
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            url = urls.first
        }
        
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            dismiss()
        }
    }
    
}

enum UIDocumentPickerType {
    case create
    case browse
}
