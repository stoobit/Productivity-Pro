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
    
    @StateObject var drawingModel: PPDrawingModel = PPDrawingModel()
    
    var pdfRendering: Bool
    var size: CGSize
    
    var body: some View {
        if page.canvasType == .pencilKit && pdfRendering == false {
            PencilKitViewWrapper(
                size: size,
                page: $page,
                toolManager: toolManager,
                subviewManager: subviewManager
            )
            
        } else {
            PPDrawingView(
                drawingModel: drawingModel,
                scale: toolManager.zoomScale,
                frame: getFrame()
            )
            .disabled(!toolManager.isCanvasEnabled)
            .allowsHitTesting(toolManager.isCanvasEnabled)
        }
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
