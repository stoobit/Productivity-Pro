//
//  PageBackgroundPDF.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 28.03.23.
//

import SwiftUI
import PDFKit

struct PageBackgroundPDF: View, Equatable {
    
    @State private var renderedBackground: UIImage?
    
    @Binding var page: Page
    @Binding var offset: CGFloat
    
    @StateObject var toolManager: ToolManager
    
    var isOverview: Bool
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
                    .onChange(of: toolManager.zoomScale) { _ in
                        if toolManager.selectedTab == page.id {
                            render()
                        }
                    }
                
            } else {
               LoadingView()
            }
        }
        .allowsHitTesting(false)
        .onAppear {
            if toolManager.selectedTab == page.id {
                render()
            } else {
                renderPreview()
            }
        }
        .onChange(of: offset) { value in
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
    
    static func == (
        lhs: PageBackgroundPDF,
        rhs: PageBackgroundPDF
    ) -> Bool {
        true
    }
    
    func renderPreview() {
        if let media = page.backgroundMedia {
            if renderedBackground == nil {
                let thumbnail = PDFDocument(data: media)?.page(at: 0)?.thumbnail(of: CGSize(
                    width: getFrame().width * 0.2,
                    height: getFrame().width * 0.2
                ), for: .mediaBox)
                
                renderedBackground = thumbnail
            }
        }
    }
    
    func render() {
        if let media = page.backgroundMedia {
            let thumbnail = PDFDocument(data: media)?.page(at: 0)?.thumbnail(of: CGSize(
                width: getFrame().width * 2.5 * toolManager.zoomScale,
                height: getFrame().width * 2.5 * toolManager.zoomScale
            ), for: .mediaBox)
            
            renderedBackground = thumbnail
        }
    }
    
    @ViewBuilder func LoadingView() -> some View {
        Text("Loading...")
            .font(.system(size: 20 * toolManager.zoomScale))
            .frame(
                width: toolManager.zoomScale * getFrame().width,
                height: toolManager.zoomScale * getFrame().height
            )
            .scaleEffect(1/toolManager.zoomScale)
    }
    
}
