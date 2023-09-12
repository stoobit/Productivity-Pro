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
        return Coordinator(url: $url)
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        @Binding var url: URL?
        
        init(url: Binding<URL?>) {
            _url = url
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            url = urls.first
        }
    }
    
}

enum UIDocumentPickerType {
    case create
    case browse
}

#Preview {
    DocumentPickerViewController(url: .constant(URL(string: "")), type: .browse)
}
