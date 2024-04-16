//
//  UITFCoordinator.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 16.04.24.
//

import SwiftUI

extension UITFRepresentable {
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: UITFRepresentable
        
        init(_ parent: UITFRepresentable) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {}
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}
