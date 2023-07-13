//
//  DrawingViewRepresentable.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 16.04.23.
//

import SwiftUI
import PencilKit

struct DrawingViewRepresentable: UIViewRepresentable {
    
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
        
        #if DEBUG
        canvasView.drawingPolicy = .anyInput
        #else
        canvasView.drawingPolicy = .pencilOnly
        #endif

        adoptScale()
        
        try? canvasView.drawing = PKDrawing(data: page.canvas)
        
        canvasView.overrideUserInterfaceStyle = colorScheme()
        toolPicker.colorUserInterfaceStyle = colorScheme()
        
        toolManager.zoomScale = 1
        canvasView.bounds.size = CGSize(
            width: getFrame().width * toolManager.zoomScale,
            height: getFrame().height * toolManager.zoomScale
        )
        
        let longPressed = UILongPressGestureRecognizer(
            target: context.coordinator,
            action: #selector(context.coordinator.recognizeObject(_:))
        )
        
        canvasView.addGestureRecognizer(longPressed)
        
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
        if toolManager.isEditorVisible == false {
            toolPicker.isRulerActive = false
            canvasView.isRulerActive = false
        }
        
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
            toolPicker: $toolPicker
        )
    }
    
    class Coordinator: NSObject, PKCanvasViewDelegate {
        @Binding var drawingChanged: Bool
        @Binding var toolPicker: PKToolPicker
        
        init(
            drawingChanged: Binding<Bool>,
            toolPicker: Binding<PKToolPicker>
        ) {
            _drawingChanged = drawingChanged
            _toolPicker = toolPicker
        }
        
        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            drawingChanged = true
        }
        
        @objc func recognizeObject(_ gestureRecognizer: UIGestureRecognizer) {
            print("recognition")
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
        
        if  page.backgroundColor == "pagewhite" ||  page.backgroundColor == "white" ||  page.backgroundColor == "pageyellow" ||  page.backgroundColor == "yellow"{
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
