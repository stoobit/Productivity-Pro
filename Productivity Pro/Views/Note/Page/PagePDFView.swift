//
//  PDFKitRepresentedView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 28.03.23.
//

import SwiftUI
import PDFKit

struct PDFKitRepresentedView: UIViewRepresentable {

    @Binding var pdfView: PDFView
    @Binding var page: Page
    @StateObject var toolManager: ToolManager
    
    let backgroundData: Data?
    
    func makeUIView(context: Context) -> PDFView {
        
        if let data = backgroundData {
            pdfView.document = PDFDocument(data: data)
        }
        
        pdfView.displayMode = .singlePage
        pdfView.isUserInteractionEnabled = false
        pdfView.pageShadowsEnabled = false
        pdfView.backgroundColor = .white
        pdfView.motionEffects = []
        pdfView.displayMode = .singlePage
        pdfView.isOpaque = false
        pdfView.autoScales = false
        
        setScale()
            
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        setScale()
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
    
    func setScale() {
        let bounds: CGRect = (pdfView.document?.page(
            at: 0
        )?.bounds(for: .mediaBox)) ?? .zero
        
        if page.isPortrait {
            pdfView.scaleFactor = longSide / bounds.height
        } else {
            pdfView.scaleFactor = longSide / bounds.width
        }
    }
    
}

struct PagePDFView: View {
    
    @State var pdfView: PDFView = PDFView()
    
    @Binding var page: Page
    @StateObject var toolManager: ToolManager
    
    var body: some View {
        PDFKitRepresentedView(
            pdfView: $pdfView,
            page: $page,
            toolManager: toolManager,
            backgroundData: page.backgroundMedia
        )
        .frame(
            width: getFrame().width,
            height: getFrame().height
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
