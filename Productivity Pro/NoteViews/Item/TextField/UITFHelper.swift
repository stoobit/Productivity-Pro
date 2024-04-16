//
//  UITFHelper.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 16.04.24.
//

import SwiftUI

extension UITFRepresentable {
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
