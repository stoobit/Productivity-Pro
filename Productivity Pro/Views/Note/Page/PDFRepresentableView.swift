//
//  PDFRepresentationView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.06.23.
//

import SwiftUI
import PDFKit
import QuickLook

struct BackgroundRepresentationView: UIViewControllerRepresentable {
    
    var data: Data
    
    func makeUIViewController(context: Context) -> QLPreviewController {
        let controller = QLPreviewController()
        
        controller.dataSource = data as? any QLPreviewControllerDataSource
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: QLPreviewController, context: Context) {
        
    }
    
}

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
        
        pdfView.displayMode = .singlePage
        pdfView.backgroundColor = .clear
        pdfView.isUserInteractionEnabled = false
        pdfView.pageShadowsEnabled = false
        pdfView.interpolationQuality = .none
        pdfView.document = document
        pdfView.scaleFactor = scaleFactor()
        pdfView.layoutDocumentView()

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

class CGPDFView: UIView {
    
    var page: CGPDFPage?
    
    let currentFrame = CGRect(x: 0, y: 0, width: longSide, height: shortSide)
    let scale: CGFloat = 1
    
    init(_ background: Data?) {
        super.init(frame: currentFrame)
        
        if let data = background {
            print("did work 1")
            if let provider = CGDataProvider(data: data as CFData) {
                print("did work 2")
                if let document = CGPDFDocument(provider) {
                    print("did work 3")
                    if let page = document.page(at: 1) {
                        print("did work 4")
                        self.page = page
                    }
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ layer: CALayer, in ctx: CGContext) {
        // Fill the background with white.
        ctx.setFillColor(UIColor.white.cgColor)
        ctx.fill(currentFrame)
        print("did work 5")
        
        guard let page = self.page else {return}
        print("did work 6")
        
        let box = page.getBoxRect(.mediaBox)
        let (xScale, yScale, xTranslate, yTranslate) = getTranslationAndScale(forRect: currentFrame, box: box)
        
        print("did work 7")
        
        let xScaleA = xScale * scale
        let yScaleA = yScale * scale
        
        ctx.scaleBy(x: xScaleA, y: yScaleA)
        ctx.saveGState()
        print("did work 8")
        ctx.translateBy(x: xTranslate, y: yTranslate + box.size.height)
        
        // Flip the context so that the PDF page is rendered right side up.
        ctx.scaleBy(x: 1.0, y: -1.0)
        ctx.saveGState()
        print("did work 9")
        ctx.clip(to: box)
        ctx.drawPDFPage(page)
        print("did work 10")
        ctx.restoreGState()
        print("did work 11")
    }
    
    func getTranslationAndScale(forRect rect:CGRect, box:CGRect) -> (CGFloat, CGFloat, CGFloat, CGFloat) {
        let boxRatio = box.size.width / box.size.height;
        
        var xScale:CGFloat = 1.0
        var yScale:CGFloat = 1.0
        var xTranslate:CGFloat = 0.0
        var yTranslate:CGFloat = 0.0
        
        xScale = rect.size.width > box.size.width ? 1 : rect.size.width / box.size.width;
        var newSize = CGSize()
        newSize.width = box.size.width * xScale
        newSize.height = newSize.width / boxRatio
        if newSize.height > rect.size.height {
            newSize.height = rect.size.height
            newSize.width = newSize.height * boxRatio
        }
        
        xScale = newSize.width / box.size.width
        yScale = newSize.height / box.size.height
        
        xTranslate = (rect.size.width - newSize.width) / 2
        yTranslate = (rect.size.height - newSize.height) / 2
        
        return (xScale, yScale, xTranslate, yTranslate)
    }
    
}

struct CGPDFViewRepresentable: UIViewRepresentable {
    
    @Binding var page: Page
    
    func makeUIView(context: Context) -> CGPDFView {
        let view = CGPDFView(page.backgroundMedia)
        
        return view
    }
    
    func updateUIView(_ uiView: CGPDFView, context: Context) {
        
    }
    
}
