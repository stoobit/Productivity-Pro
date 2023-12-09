//
//  UnderlayingCanvasView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 27.11.22.
//

import SwiftUI
import PencilKit

struct PageView: View {
    @Environment(\.colorScheme) var cs
    
    @Environment(ToolManager.self) var toolManager
    @Environment(SubviewManager.self) var subviewManager
    
    @AppStorage("defaultFont")
    var defaultFont: String = "Avenir Next"
    
    @AppStorage("defaultFontSize")
    var defaultFontSize: Double = 12
    
    var note: PPNoteModel
    @Bindable var page: PPPageModel
    
    @Binding var scale: CGFloat
    @Binding var offset: CGPoint
    
    let size: CGSize
    
    // MARK: - unchecked
    @State var isTargeted: Bool = true
    
    var pdfRendering: Bool = false
    var highResolution: Bool = false
    
    var body: some View {
        ZStack {
            ZStack {
                PageBackgroundView(page: page)
                BackgroundTemplateView(page: page, scale: $scale)
                
                if page.type == PPPageType.pdf.rawValue {
                    PageBackgroundPDF(page: page, scale: $scale)
                } else if page.type == PPPageType.image.rawValue {
                    PageBackgroundScan(page: page, scale: $scale)
                } 
            }
            .onTapGesture { onBackgroundTap() }
            .allowsHitTesting(toolManager.pencilKit == false)
            
            PageItemView(
                note: note,
                page: page,
                scale: $scale,
                highResolution: highResolution,
                pdfRendering: pdfRendering
            )
            .allowsHitTesting(toolManager.pencilKit == false)
            
            PencilKitViewWrapper(page: page, scale: $scale, size: size)
                .allowsHitTesting(toolManager.pencilKit)
            
            SnapItemView(page: page, scale: $scale)
                .scaleEffect(1/scale)
                .allowsHitTesting(false)
            
        }
        .dropDestination(for: Data.self) { items, location in
            onDrop(items: items)
            return true
        }
        .disabled(subviewManager.isPresentationMode)
        .frame(
            width: getFrame().width * scale,
            height: getFrame().height * scale
        )
            
    }
}
