//
//  UITFUpdate.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 16.04.24.
//

import SwiftUI

extension UITFRepresentable {
    func updateUIView(_ uiView: UITextView, context: Context) {
        adopt(view: uiView, to: scale * 2.5)
    }
}
