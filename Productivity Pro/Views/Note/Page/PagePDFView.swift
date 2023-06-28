//
//  PDFKitRepresentedView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 28.03.23.
//

import SwiftUI
import PDFKit

struct PagePDFView: View, Equatable {
    
    @Binding var note: Note
    @Binding var page: Page
    @Binding var offset: CGFloat
    
    @StateObject
    var toolManager: ToolManager
    
    @State
    private var renderedBackground: UIImage? = nil
    
    var savedRendering: UIImage? {
        guard let index = note.pages.firstIndex(of: page) else {
            return nil
        }
        
        return toolManager.baseRenderings[index]
    }
    
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
                if savedRendering == nil {
                    
                    renderSaving()
                    renderedBackground = savedRendering
                    
                } else if renderedBackground == nil {
                    renderedBackground = savedRendering
                }
            }
            .onChange(of: toolManager.zoomScale) { _ in
                if page.id == toolManager.selectedTab {
                    renderBackground()
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
    
    func renderBackground() {
        DispatchQueue.global(qos: .userInitiated).async {
            if let media = page.backgroundMedia {
                if let pdf = PDFDocument(data: media)?.page(at: 0) {
                    
                    let size: CGSize = CGSize(
                        width: getFrame().width * 2 * toolManager.zoomScale,
                        height: getFrame().height * 2 * toolManager.zoomScale
                    )
                    
                    renderedBackground = pdf.thumbnail(
                        of: size, for: .mediaBox
                    )
                    
                }
            }
        }
    }
    
    func renderSaving() {
        DispatchQueue.global(qos: .userInitiated).async {
            if let media = page.backgroundMedia {
                if let pdf = PDFDocument(data: media)?.page(at: 0) {
                    
                    let size: CGSize = CGSize(
                        width: getFrame().width * 2 * toolManager.zoomScale,
                        height: getFrame().height * 2 * toolManager.zoomScale
                    )
                    
                    guard let index = note.pages.firstIndex(of: page) else { return }
                    toolManager.baseRenderings[index] = pdf.thumbnail(
                        of: size, for: .mediaBox
                    )
                    
                }
            }
        }
    }
    
    static func == (lhs: PagePDFView, rhs: PagePDFView) -> Bool {
        lhs.renderedBackground == rhs.renderedBackground
    }
}
