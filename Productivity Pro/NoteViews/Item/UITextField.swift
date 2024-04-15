//
//  UITextField.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 15.04.24.
//

import SwiftUI

struct UITextField: UIViewRepresentable {
    var scale: CGFloat
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        
        view.text = "Hello World"
        view.textColor = .black
        view.backgroundColor = .clear
        
        scaleView(view: view, scale: scale * 2.5)
        scaleLayer(layer: view.layer, scale: scale * 2.5)
        
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        scaleView(view: uiView, scale: scale * 2.5)
        scaleLayer(layer: uiView.layer, scale: scale * 2.5)
    }
    
    func scaleView(view: UIView, scale: CGFloat) {
        view.contentScaleFactor = scale
        for vi in view.subviews {
            scaleView(view: vi, scale: scale)
        }
    }

    func scaleLayer(layer: CALayer, scale: CGFloat) {
        layer.contentsScale = scale
        if layer.sublayers == nil {
            return
        }
        for la in layer.sublayers! {
            scaleLayer(layer: la, scale: scale)
        }
    }
}
