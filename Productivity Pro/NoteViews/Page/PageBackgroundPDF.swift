//
//  PageBackgroundPDF.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 28.03.23.
//

import PDFKit
import SwiftUI

struct PageBackgroundPDF: View {
    @Bindable var page: PPPageModel
    
    @State var loadedPDF: PDFDocument?
    @Binding var scale: CGFloat
    
    var body: some View {
        ZStack {
            PDFView(document: loadedPDF)
        }
        .onAppear {
            if loadedPDF == nil {
                DispatchQueue.main.async {
                    if let media = page.media {
                        loadedPDF = PDFDocument(data: media)
                    }
                }
            }
        }
    }
    
    @ViewBuilder func PDFView(document: PDFDocument?) -> some View {
        if let pdf = document {
            PDFKitView(pdfDocument: pdf, size: getFrame())
                .allowsHitTesting(false)
                .frame(
                    width: getFrame().width,
                    height: getFrame().height
                )
        }
    }
    
    func getFrame() -> CGSize {
        var frame: CGSize = .zero
        
        if page.isPortrait {
            frame = CGSize(width: shortSide, height: longSide)
        } else {
            frame = CGSize(width: longSide, height: shortSide)
        }
        
        return frame
    }
}

struct PDFKitView: UIViewRepresentable {
    var pdfDocument: PDFDocument
    var size: CGSize
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = pdfDocument
        pdfView.isUserInteractionEnabled = false
        pdfView.pageShadowsEnabled = false
        
        pdfView.frame = CGRect(origin: .zero, size: size)
        pdfView.scaleFactor = pdfView.scaleFactorForSizeToFit
        
        pdfView.backgroundColor = .clear
        
        return pdfView
    }
    
    func updateUIView(_ pdfView: PDFView, context: Context) {
        pdfView.document = pdfDocument
    }
}
