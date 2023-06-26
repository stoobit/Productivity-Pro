//
//  DrawingViewRepresentable.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 16.04.23.
//

import SwiftUI
import PencilKit

struct DrawingViewRepresentable: UIViewRepresentable {
   
    @State var oldTool: PKTool?
    
    var size: CGSize
    
    @Binding var page: Page
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    @Binding var canvasView: PKCanvasView
    @Binding var toolPicker: PKToolPicker
    
    @Binding var drawingChanged: Bool
    
    func makeUIView(context: Context) -> PKCanvasView {
        
        canvasView.delegate = context.coordinator
        
        canvasView.backgroundColor = .clear
        canvasView.bouncesZoom = false
        canvasView.isScrollEnabled = false
        
        canvasView.showsVerticalScrollIndicator = false
        canvasView.showsHorizontalScrollIndicator = false
        
        toolPicker.showsDrawingPolicyControls = false
        canvasView.drawingPolicy = .pencilOnly

        adoptScale()
        
        try? canvasView.drawing = PKDrawing(data: page.canvas)
        
        canvasView.overrideUserInterfaceStyle = colorScheme()
        toolPicker.colorUserInterfaceStyle = colorScheme()
        
        toolManager.zoomScale = 1
        canvasView.bounds.size = CGSize(
            width: getFrame().width * toolManager.zoomScale,
            height: getFrame().height * toolManager.zoomScale
        )
        
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
        if canvasView.zoomScale != toolManager.zoomScale {
            canvasView.setZoomScale(toolManager.zoomScale, animated: false)
        }
        
        if toolManager.isLocked {
            uiView.pinchGestureRecognizer?.isEnabled = false
        } else {
            uiView.pinchGestureRecognizer?.isEnabled = true
        }
        
        canvasView.overrideUserInterfaceStyle = colorScheme()
        toolPicker.colorUserInterfaceStyle = colorScheme()
        
        adoptScale()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(
            drawingChanged: $drawingChanged,
            toolPicker: $toolPicker,
            oldTool: oldTool
        )
    }
    
    class Coordinator: NSObject, PKCanvasViewDelegate {
        @Binding var drawingChanged: Bool
        @Binding var toolPicker: PKToolPicker
        
        var oldTool: PKTool?
        
        init(
            drawingChanged: Binding<Bool>,
            toolPicker: Binding<PKToolPicker>,
            
            oldTool: PKTool?
        ) {
            _drawingChanged = drawingChanged
            _toolPicker = toolPicker
            
            self.oldTool = oldTool
        }
        
        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            drawingChanged = true
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
    
    func colorScheme() -> UIUserInterfaceStyle {
        var cs: UIUserInterfaceStyle = .dark
        
        if page.backgroundColor == "pageyellow" || page.backgroundColor == "pagewhite" {
            cs = .light
        }
        
        return cs
    }
    
    func adoptScale() {
        canvasView.minimumZoomScale = toolManager.zoomScale
        canvasView.maximumZoomScale = toolManager.zoomScale
        
        canvasView.setZoomScale(toolManager.zoomScale, animated: false)
    }
    
}
