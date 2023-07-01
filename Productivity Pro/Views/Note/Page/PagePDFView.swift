//
//  PDFKitRepresentedView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 28.03.23.
//

import SwiftUI
import PDFKit

struct PagePDFView: View, Equatable {
    
    @Binding var page: Page
    @StateObject var toolManager: ToolManager
    
    var body: some View {
        //        PDFRepresentationView(
        //            encodedPDF: page.backgroundScan,
        //            isPortrait: page.isPortrait
        //        )
        //        .equatable()
        Image(
            uiImage: drawPDFFromURL(
                data: page.backgroundMedia!
            )!
        )
        .resizable()
        .scaledToFit()
        .frame(
            width: getFrame().width * toolManager.zoomScale,
            height: getFrame().height * toolManager.zoomScale
        )
        .scaleEffect(1/toolManager.zoomScale)
    }
    
    func drawPDFFromURL(data: Data) -> UIImage? {
        guard let document = CGPDFDocument(
            CGDataProvider(data: data as CFData)!
        ) else { return nil }
        
        guard let page = document.page(at: 1) else { return nil }
        
        let dpi: CGFloat = 1
        
        let pageRect = page.getBoxRect(.mediaBox)
        let renderer = UIGraphicsImageRenderer(size: CGSize(
            width: getFrame().width * dpi,
            height: getFrame().height * dpi)
        )
        
        let img = renderer.image { ctx in
            UIColor.white.set()
            ctx.fill(pageRect)
            
            ctx.cgContext.translateBy(x: 0.0, y: getFrame().height * dpi)
            ctx.cgContext.scaleBy(x: 1.0 * dpi, y: -1.0 * dpi)
            
            ctx.cgContext.drawPDFPage(page)
        }
        
        return img
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
    
    static func == (lhs: PagePDFView, rhs: PagePDFView) -> Bool {
        true
    }
}
