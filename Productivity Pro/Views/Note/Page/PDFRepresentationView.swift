//
//  PDFRepresentationView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.06.23.
//

import SwiftUI
import UIKit

class CGPDFView: UIView {
    
    override func draw(_ layer: CALayer, in ctx: CGContext) {
        
    }
    
}

struct CGPDFViewRepresentable: UIViewRepresentable {
    
    func makeUIView(context: Context) -> CGPDFView {
        return CGPDFView()
    }
    
    func updateUIView(_ uiView: CGPDFView, context: Context) {
        
    }
    
}
