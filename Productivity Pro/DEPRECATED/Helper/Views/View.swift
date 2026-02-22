//
//  View.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 05.07.23.
//

import SwiftUI

extension View {
    func snapshot(scale: CGFloat, frame: CGSize) -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        view?.bounds = CGRect(origin: .zero, size: frame)
        view?.backgroundColor = .clear

        let format = UIGraphicsImageRendererFormat()
        format.scale = scale
        
        let renderer = UIGraphicsImageRenderer(size: frame, format: format)
        
        return renderer.image { ctx in
            view?.drawHierarchy(
                in: CGRect(origin: .zero, size: frame), afterScreenUpdates: true
            )
        }
    }
}
