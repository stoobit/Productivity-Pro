//
//  TemplatePreview.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.09.23.
//

import SwiftUI
import SVGKit

struct SVGKFastImageViewSUI: UIViewRepresentable {
    var data: Data
    var size: CGSize
    
    func makeUIView(context: Context) -> SVGKFastImageView {
        let view = SVGKFastImageView(
            svgkImage: SVGKImage(data: data) ?? SVGKImage()
        ) ?? SVGKFastImageView()
        
        view.image.size = size
        view.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        
        return view
    }
    
    func updateUIView(_ uiView: SVGKFastImageView, context: Context) { }

}

