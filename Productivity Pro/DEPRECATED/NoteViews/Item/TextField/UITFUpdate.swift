//
//  UITFUpdate.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 16.04.24.
//

import SwiftUI
import RichTextKit

extension UITFRepresentable {
    func updateUIView(_ uiView: RichTextView, context: Context) {
//        adopt(view: uiView, to: scale * 2.5)
        
        if toolManager.isEditingText == false {
            uiView.resignFirstResponder()
        }
    }
}
