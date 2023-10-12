//
//  PageBackgroundPDF.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 28.03.23.
//

import SwiftUI
import PDFKit

struct PageBackgroundPDF: View {
    var page: PPPageModel
    
    @State var loadedPDF: PDFPage?
    @State var renderedPDF: UIImage?
    
    @Binding var scale: CGFloat
    
    var body: some View {
        ZStack {
            if let rendering = renderedPDF {
                Image(uiImage: rendering)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: scale * getFrame().width,
                        height: scale * getFrame().height
                    )
                    .scaleEffect(1 / scale)
            }
        }
        .onChange(of: scale, initial: true) {
            render()
        }
    }
    
    func render() {
        if loadedPDF == nil {
            guard let data = page.media else { return }
            let pdfDocument = PDFDocument(data: data)
            
            loadedPDF = pdfDocument?.page(at: 0)
        }
        
        if let loaded = loadedPDF {
            let image = loaded.thumbnail(of: CGSize(
                width: getFrame().width * 2.5 * scale,
                height: getFrame().width * 2.5 * scale
            ), for: .mediaBox)
            
            renderedPDF = image
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
