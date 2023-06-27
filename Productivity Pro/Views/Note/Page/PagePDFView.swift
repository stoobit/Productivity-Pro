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
    @Binding var offset: CGFloat 
    
    @StateObject
    var toolManager: ToolManager
    
    @State private var renderedBackground: UIImage? = nil
    
    var body: some View {
        Image(uiImage: renderedBackground ?? UIImage())
            .resizable()
            .scaledToFit()
            .frame(
                width: toolManager.zoomScale * getFrame().width,
                height: toolManager.zoomScale * getFrame().height
            )
            .scaleEffect(1/toolManager.zoomScale)
            .onAppear() {
                if renderedBackground == nil {
                    renderPage()
                }
            }
            .onChange(of: toolManager.zoomScale) { _ in
                if page.id == toolManager.selectedTab {
                    renderPage()
                }
            }
            .onDisappear {
                renderPreview()
            }
            .onChange(of: offset) { _ in
                if toolManager.selectedTab == page.id && offset == 0 {
                    renderPage()
                }
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
        DispatchQueue.global(qos: .userInitiated).async {
            if let media = page.backgroundMedia {
                if let pdf = PDFDocument(data: media)?.page(at: 0) {
                    Task(priority: .userInitiated) {
                        
                        let size: CGSize = pdf.bounds(
                            for: .mediaBox
                        ).size * 0.7
                        
                        renderedBackground = pdf.thumbnail(
                            of: size, for: .mediaBox
                        )
                    }
                }
            }
        }
    }
    
    func renderPage() {
        DispatchQueue.global(qos: .userInitiated).async {
            if let media = page.backgroundMedia {
                if let pdf = PDFDocument(data: media)?.page(at: 0) {
                    Task(priority: .userInitiated) {
                        
                        let size: CGSize = pdf.bounds(
                            for: .mediaBox
                        ).size * toolManager.zoomScale * 6
                        
                        renderedBackground = pdf.thumbnail(
                            of: size, for: .mediaBox
                        )
                    }
                }
            }
        }
    }
    
}
