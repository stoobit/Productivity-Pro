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

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.delegate = context.coordinator
        view.backgroundColor = .clear

        scaleView(view: view, scale: scale * 2.5)
        scaleLayer(layer: view.layer, scale: scale * 2.5)

        return view
    }
}
