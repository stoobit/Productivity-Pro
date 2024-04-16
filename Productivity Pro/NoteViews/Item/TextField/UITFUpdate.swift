//
//  UITFUpdate.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 16.04.24.
//

import SwiftUI

extension UITFRepresentable {
    func updateUIView(_ uiView: UITextView, context: Context) {
        scaleView(view: uiView, scale: scale * 2.5)
        scaleLayer(layer: uiView.layer, scale: scale * 2.5)
    }
}
