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
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.adopt(view: textView, to: self.parent.scale * 2.5)
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            self.parent.toolManager.isEditingText = true
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            self.parent.toolManager.isEditingText = false
            self.parent.textField.attributedString = textView.attributedText.data()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}
