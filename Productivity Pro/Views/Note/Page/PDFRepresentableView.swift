//
//  PDFRepresentationView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.06.23.
//

import SwiftUI
import PDFKit

struct PDFRepresentationView: UIViewRepresentable, Equatable {

    var isPortrait: Bool
    @Binding var document: PDFDocument?

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        
        if let pdf = document {
            pdfView.document = pdf
        }
        
        pdfView.displayMode = .singlePage
        pdfView.backgroundColor = .clear
        pdfView.isUserInteractionEnabled = false
        pdfView.pageShadowsEnabled = false
        pdfView.interpolationQuality = .none
        pdfView.scaleFactor = scaleFactor()
        
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        if let pdf = document {
            uiView.document = pdf
        }
    }
    
    func getFrame() -> CGSize {
        var frame: CGSize = .zero
        
        if isPortrait {
            frame = CGSize(width: shortSide, height: longSide)
        } else {
            frame = CGSize(width: longSide, height: shortSide)
        }
        
        return frame
    }
    
    func scaleFactor() -> CGFloat {
        var scale: CGFloat = .zero
        
        if isPortrait {
            guard let width = document?.page(at: 0)?
                .bounds(for: .mediaBox).width else { return 0 }
            
            scale = getFrame().width / width
            
        } else {
            guard let height = document?.page(at: 0)?
                .bounds(for: .mediaBox).height else { return 0 }
            
            scale = getFrame().height / height
            
        }
        
        return scale
    }
    
    static func == (
        lhs: PDFRepresentationView,
        rhs: PDFRepresentationView
    ) -> Bool {
        true
    }
    
}
