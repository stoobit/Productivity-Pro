//
//  PageBackgroundPDF.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 28.03.23.
//

import SwiftUI
import PDFKit

struct PageBackgroundPDF: View {
    
    @State private var renderedBackground: UIImage?
    
    var page: Page
    
    @Binding var document: Document
    @Binding var offset: CGFloat
    
    @Bindable var toolManager: ToolManager
    
    var isOverview: Bool
    var pdfRendering: Bool
    
    var body: some View {
        ZStack {
            if let rendering = renderedBackground {
                Image(uiImage: rendering)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: toolManager.zoomScale * getFrame().width,
                        height: toolManager.zoomScale * getFrame().height
                    )
                    .scaleEffect(1/toolManager.zoomScale)
                    .onChange(of: toolManager.zoomScale) {
                        if toolManager.selectedTab == page.id && offset == 0 {
                            render()
                        }
                    }
                
            }
        }
        .allowsHitTesting(false)
        .onAppear {
            if pdfRendering {
                renderPDFQuality()
            } else if toolManager.selectedTab == page.id {
                render()
            } else {
                renderPreview()
            }
        }
        .onChange(of: offset) { old, value in
            if offset == 0 &&
                toolManager.selectedTab == page.id &&
                isOverview == false
            {
                render()
            }
        }
        .onDisappear {
            renderedBackground = nil
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
    
    func renderPreview() {
        if renderedBackground == nil {
            
            guard let index = document.note.pages.firstIndex(of: page) else {
                return
            }
            
            if toolManager.preloadedMedia.indices.contains(index) {
                guard let pdf = toolManager.preloadedMedia[index] else {
                    return
                }
            
                let thumbnail = pdf.page(at: 0)?.thumbnail(of: CGSize(
                    width: getFrame().width * 0.2,
                    height: getFrame().width * 0.2
                ), for: .mediaBox)
                
                renderedBackground = thumbnail
            }
        }
    }
    
    func render() {
        guard let index = document.note.pages.firstIndex(of: page) else {
            return
        }
        
        if toolManager.preloadedMedia.indices.contains(index) {
            guard let pdf = toolManager.preloadedMedia[index] else {
                return
            }
            
            let thumbnail = pdf.page(at: 0)?.thumbnail(of: CGSize(
                width: getFrame().width * 2.5 * toolManager.zoomScale,
                height: getFrame().width * 2.5 * toolManager.zoomScale
            ), for: .mediaBox)
            
            renderedBackground = thumbnail
        }
    }
    
    func renderPDFQuality() {
        if let media = page.backgroundMedia {
            let thumbnail = PDFDocument(data: media)?.page(at: 0)?.thumbnail(of: CGSize(
                width: getFrame().width * 7,
                height: getFrame().width * 7
            ), for: .mediaBox)
            
            renderedBackground = thumbnail
        }
    }
    
    static func == (
        lhs: PageBackgroundPDF,
        rhs: PageBackgroundPDF
    ) -> Bool {
        true
    }
    
}
