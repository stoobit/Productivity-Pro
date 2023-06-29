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
    var document: PDFDocument = PDFDocument()

    init(encodedPDF: Data?, isPortrait: Bool) {
        if let data = encodedPDF {
            if let pdf = PDFDocument(data: data) {
                document = pdf
            }
        }
        
        self.isPortrait = isPortrait
    }

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        
        pdfView.document = document
        pdfView.backgroundColor = .clear
        pdfView.displayMode = .singlePage
        pdfView.isUserInteractionEnabled = false
        pdfView.pageShadowsEnabled = false
        
        pdfView.interpolationQuality = .none
        
//        pdfView.minScaleFactor = scaleFactor()
//        pdfView.maxScaleFactor = scaleFactor()
//
//        pdfView.scaleFactor = scaleFactor()
//        
        print("pdf scale: \(pdfView.scaleFactor)")
        
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) { }
    
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
            guard let width = document.page(at: 0)?
                .bounds(for: .mediaBox).width else { return 0 }
            
            scale = getFrame().width / width
            
        } else {
            guard let height = document.page(at: 0)?
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
