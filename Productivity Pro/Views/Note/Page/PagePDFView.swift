//
//  PDFKitRepresentedView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 28.03.23.
//

import SwiftUI
import PDFKit

struct PagePDFView: View {
    
    @Binding var page: Page
    @StateObject var toolManager: ToolManager
    
    var body: some View {
        PDFKitRepresentedView(
            toolManager: toolManager,
            backgroundData: page.backgroundMedia
        )
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

struct PDFKitRepresentedView: UIViewRepresentable {

    @StateObject var toolManager: ToolManager
    let backgroundData: Data?
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        
        if let data = backgroundData {
            pdfView.document = PDFDocument(data: data)
        }
        
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
