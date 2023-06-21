//
//  UnderlayingCanvasView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 27.11.22.
//

import SwiftUI
import PencilKit
import PDFKit

struct PageView: View {
    
    @Environment(\.colorScheme) var cs
    
    @AppStorage("defaultFont")
    var defaultFont: String = "Avenir Next"
    
    @AppStorage("defaultFontSize")
    var defaultFontSize: Double = 12
    
    @Binding var document: ProductivityProDocument
    @Binding var page: Page
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    @State var isTargeted: Bool = true
    
    var showBackground: Bool = true
    var showToolView: Bool
    var showShadow: Bool = true
    
    var isOverview: Bool = false
    var showCanvas: Bool = true
    
    let size: CGSize
    
    var body: some View {
        LazyVStack {
            ZStack {
                ZStack {
                    PageBackgroundView(
                        page: $page,
                        toolManager: toolManager,
                        showShadow: showShadow
                    )
                    
                    BackgroundTemplateView(
                        page: page,
                        scale: toolManager.zoomScale
                    )
                    
                    if showBackground {
                        if page.type == .pdf {
                            PagePDFView(
                                page: $page,
                                toolManager: toolManager
                            )
                        } else if page.type == .image {
                            PageBackgroundScan(
                                page: $page,
                                toolManager: toolManager
                            )
                        }
                    }
                    
                }
                .onTapGesture { onBackgroundTap() }
                
                PageItemView(
                    document: $document,
                    page: $page,
                    toolManager: toolManager,
                    subviewManager: subviewManager
                )
                
                if showCanvas {
                    DrawingView(
                        size: size,
                        page: $page,
                        toolManager: toolManager,
                        subviewManager: subviewManager
                    )
                }
                
                SnapItemView(toolManager: toolManager, page: $page)
                    .scaleEffect(1/toolManager.zoomScale)
                    .allowsHitTesting(false)
                
            }
            .dropDestination(for: Data.self) { items, location in
                onDrop(items: items)
                return true
            }
            .disabled(subviewManager.isPresentationMode)
            .allowsHitTesting(!subviewManager.isPresentationMode)
            .modifier(iPhoneInteraction())
            .frame(
                width: getFrame().width * toolManager.zoomScale,
                height: getFrame().height * toolManager.zoomScale
            )
            
        }
    }
}
