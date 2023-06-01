//
//  PDFKitRepresentedView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 28.03.23.
//

import SwiftUI
import PDFKit

struct PDFKitRepresentedView: UIViewRepresentable {
    typealias UIViewType = PDFView

    @StateObject var toolManager: ToolManager
    
    let data: Data
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        
        pdfView.document = PDFDocument(data: data)
        pdfView.displayMode = .singlePage
        pdfView.isUserInteractionEnabled = false
        pdfView.pageShadowsEnabled = false
        pdfView.backgroundColor = .white
        pdfView.autoScales = false
        pdfView.motionEffects = []
        pdfView.displayMode = .singlePage
        pdfView.isOpaque = false
        
//        pdfView.bounds.size = CGSize(
            
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        uiView.scaleFactor = 2.6 * toolManager.zoomScale
    }
}
