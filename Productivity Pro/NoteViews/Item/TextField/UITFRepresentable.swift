//
//  UITFRepresentable.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 15.04.24.
//

import SwiftUI

struct UITFRepresentable: UIViewRepresentable {
    var scale: CGFloat
    var textField: PPTextFieldModel
    
    @Bindable var toolManager: ToolManager

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.delegate = context.coordinator
        view.backgroundColor = .clear
        
        if let data = textField.attributedString {
            view.attributedText = NSAttributedString(data: data)
        }

        adopt(view: view, to: scale * 2.5)
        return view
    }
}
