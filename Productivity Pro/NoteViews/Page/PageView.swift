//
//  UnderlayingCanvasView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 27.11.22.
//

import PencilKit
import SwiftUI

struct PageView: View {
    @Environment(\.colorScheme) var cs
    
    @Environment(ToolManager.self) var toolManager
    @Environment(SubviewManager.self) var subviewManager
    
    @AppStorage("defaultFont") var defaultFont: String = "Avenir Next"
    @AppStorage("defaultFontSize") var defaultFontSize: Double = 12
    
    @Bindable var note: PPNoteModel
    @Bindable var page: PPPageModel
    
    @Binding var scale: CGFloat
    @Binding var offset: CGPoint
    
    var size: CGSize = .zero
    var preloadModels: Bool = false
    var realrenderText: Bool = false

    var body: some View {
        ZStack {
            ZStack {
                PageBackgroundView(scale: $scale, page: page)
                    .shadow(color: Color.shadow.opacity(0.5), radius: 2)
                
                if preloadModels == false {
                    BackgroundTemplateView(page: page, scale: $scale)
                }
                
                if page.type == PPPageType.pdf.rawValue && !preloadModels {
                    PageBackgroundPDF(page: page, scale: $scale)
                } else if page.type == PPPageType.image.rawValue {
                    PageBackgroundScan(
                        page: page,
                        scale: $scale,
                        preloadModels: preloadModels
                    )
                }
            }
            .onTapGesture { onBackgroundTap() }
            .allowsHitTesting(toolManager.pencilKit == false)
            
            if preloadModels { RenderedPDF(page: page) }
            
            PageItemView(
                note: note, page: page, scale: $scale,
                realrenderText: realrenderText, 
                preloadModels: preloadModels
            )
            .allowsHitTesting(toolManager.pencilKit == false)
            
            if preloadModels == false {
                DrawingView(page: page, scale: $scale)
                    .allowsHitTesting(toolManager.pencilKit)
            }
            
            SnapItemView(page: page, scale: $scale)
                .scaleEffect(1 / scale)
                .allowsHitTesting(false)
        }
        .dropDestination(for: Image.self) { items, _ in
            for item in items {
                add(image: item)
            }
            return true
        }
        .dropDestination(for: String.self) { items, _ in
            for item in items {
                add(string: item)
            }
            return true
        }
        .disabled(subviewManager.isPresentationMode)
        .frame(
            width: getFrame().width * scale,
            height: getFrame().height * scale
        )
    }
}
