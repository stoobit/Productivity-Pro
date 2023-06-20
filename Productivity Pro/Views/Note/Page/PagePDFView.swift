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
    
    @State var image: UIImage? = nil
    
    var body: some View {
        Image(uiImage: image ?? UIImage())
            .resizable()
            .scaledToFit()
            .frame(
                width: toolManager.zoomScale * getFrame().width,
                height: toolManager.zoomScale * getFrame().height
            )
            .scaleEffect(1/toolManager.zoomScale)
            .allowsHitTesting(false)
            .onAppear() { onAppear() }
            .onChange(of: toolManager.zoomScale) { _ in
                if page.id == toolManager.selectedTab {
                    renderPage()
                }
            }
            .onChange(of: toolManager.selectedTab) { _ in
                if page.id == toolManager.selectedTab {
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
    
    func onAppear() {
        if let media = page.backgroundMedia {
            if let pdf = PDFDocument(data: media)?.page(at: 0) {
                Task(priority: .userInitiated) {
                    
                    let size: CGSize = pdf.bounds(
                        for: .mediaBox
                    ).size
                    
                    image = pdf.thumbnail(
                        of: size, for: .mediaBox
                    )
                }
            }
        }
    }
    
    func renderPage() {
        if let media = page.backgroundMedia {
            if let pdf = PDFDocument(data: media)?.page(at: 0) {
                Task(priority: .userInitiated) {
                    
                    let size: CGSize = pdf.bounds(
                        for: .mediaBox
                    ).size * toolManager.zoomScale * 6
                    
                    image = pdf.thumbnail(
                        of: size, for: .mediaBox
                    )
                }
            }
        }
    }
}
