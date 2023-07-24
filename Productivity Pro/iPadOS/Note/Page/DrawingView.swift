//
//  DrawingView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 18.07.23.
//

import SwiftUI

struct DrawingView: View {
    
    @Binding var page: Page
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    @StateObject var drawingModel: PPDrawingModel
    
    var pdfRendering: Bool
    var size: CGSize
    
    var body: some View {
        Group {
            if page.canvasType == .ppDrawingKit {
                PPDrawingView(
                    drawingModel: drawingModel,
                    lines: $page.lines,
                    scale: toolManager.zoomScale,
                    frame: getFrame()
                )
                .disabled(!toolManager.isCanvasEnabled)
                .allowsHitTesting(toolManager.isCanvasEnabled)
            } else if pdfRendering == false {
                PencilKitViewWrapper(
                    size: size,
                    page: $page,
                    toolManager: toolManager,
                    subviewManager: subviewManager
                )
            }
        }
        .zIndex(Double(page.items.count + 10))
    }
    
    func getFrame() -> CGSize {
        var frame: CGSize = .zero
        
        if page.isPortrait {
            frame = CGSize(
                width: shortSide,
                height: longSide
            )
        } else {
            frame = CGSize(width: longSide, height: shortSide)
        }
        
        return frame
    }
    
}
