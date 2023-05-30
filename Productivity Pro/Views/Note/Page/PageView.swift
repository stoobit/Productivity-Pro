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
    
    @AppStorage("defaultFont") var defaultFont: String = "Avenir Next"
    @AppStorage("defaultFontSize") var defaultFontSize: Double = 12
    
    @Binding var document: Productivity_ProDocument
    @Binding var page: Page
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    @State var isTargeted: Bool = true
    @State var renderedBackground: UIImage?
    
    @State var text: NSAttributedString = NSAttributedString("")
    
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
                    if showBackground {
                        Rectangle()
                            .foregroundColor(Color(page.backgroundColor))
                            .frame(
                                width: toolManager.zoomScale * getFrame().width,
                                height: toolManager.zoomScale * getFrame().height
                            )
                            .scaleEffect(1/toolManager.zoomScale)
                            .shadow(
                                color: Color.primary.opacity(showShadow ? 0.8 : 0),
                                radius: 2
                            )
                            .frame(
                                width: getFrame().width * toolManager.zoomScale,
                                height: getFrame().height * toolManager.zoomScale
                            )
                        
                        BackgroundView(page: page, scale: toolManager.zoomScale)
                            .frame(
                                width: toolManager.zoomScale * getFrame().width,
                                height: toolManager.zoomScale * getFrame().height
                            )
                            .scaleEffect(1/toolManager.zoomScale)
                        
                        if page.type == .pdf {
                            Image(uiImage: renderedBackground ?? UIImage())
                                .resizable()
                                .scaledToFit()
                                .frame(
                                    width: toolManager.zoomScale * getFrame().width,
                                    height: toolManager.zoomScale * getFrame().height
                                )
                                .scaleEffect(1/toolManager.zoomScale)
                                .allowsHitTesting(false)
                                .task(priority: .userInitiated) {
                                    if renderedBackground == nil {
                                        renderPDF()
                                    }
                                }
                                .onChange(of: toolManager.zoomScale) { _ in
                                    Task(priority: .userInitiated) {
                                        renderPDF()
                                    }
                                }
                            
                        } else if page.type == .image {
                            Image(uiImage: renderedBackground ?? UIImage())
                                .resizable()
                                .scaledToFit()
                                .frame(
                                    width: toolManager.zoomScale * getFrame().width,
                                    height: toolManager.zoomScale * getFrame().height
                                )
                                .scaleEffect(1/toolManager.zoomScale)
                                .allowsHitTesting(false)
                                .task(priority: .userInitiated) {
                                    renderedBackground = UIImage(data: page.backgroundMedia ?? Data())
                                }
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
                .frame(
                    width: toolManager.zoomScale * getFrame().width,
                    height: toolManager.zoomScale * getFrame().height
                )
                .clipShape(Rectangle())
                .scaleEffect(1/toolManager.zoomScale)
                
                if showCanvas {
                    DrawingView(
                        size: size,
                        page: $page,
                        toolManager: toolManager,
                        subviewManager: subviewManager
                    )
                    .frame(
                        width: toolManager.zoomScale * getFrame().width,
                        height: toolManager.zoomScale * getFrame().height
                    )
                    .scaleEffect(1/toolManager.zoomScale)
                    .allowsHitTesting(toolManager.isCanvasEnabled)
                    .zIndex(Double(page.items.count + 20))
                }
                
                SnapItemView(toolManager: toolManager, page: $page)
                    .scaleEffect(1/toolManager.zoomScale)
                    .allowsHitTesting(false)
            
            }
            .dropDestination(for: Data.self) { items, location in
                toolManager.showProgress = true
                Task {
                    await MainActor.run {
                        for item in items {
                            if let string = String(data: item, encoding: .utf8) {
                                addTextField(text: string)
                            } else if let image = UIImage(data: item) {
                                addImage(img: image)
                            }
                        }
                        
                        toolManager.showProgress = false
                    }
                }
                
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
