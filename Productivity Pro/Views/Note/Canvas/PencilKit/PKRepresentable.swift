//
//  DrawingViewRepresentable.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 16.04.23.
//

import SwiftUI
import PencilKit

struct PKRepresentable: UIViewRepresentable {
    @Environment(ToolManager.self) var toolManager
    
    @Bindable var page: PPPageModel
    @Binding var scale: CGFloat
    
    @Binding var canvasView: PKCanvasView
    @Binding var toolPicker: PKToolPicker
    @Binding var drawingChanged: Bool
    @Binding var strokeCount: Int
    
    let size: CGSize
    
    func makeUIView(context: Context) -> PKCanvasView {
        Task { @MainActor in
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
            
            scale = 1
            canvasView.bounds.size = CGSize(
                width: getFrame().width * scale,
                height: getFrame().height * scale
            )
            
            strokeCount = canvasView.drawing.strokes.count
        }
        
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        if toolManager.editorVisible == false {
            toolPicker.isRulerActive = false
            canvasView.isRulerActive = false
        }
        
        if canvasView.zoomScale != scale {
            canvasView.setZoomScale(scale, animated: false)
        }
        
        canvasView.overrideUserInterfaceStyle = colorScheme()
        toolPicker.colorUserInterfaceStyle = colorScheme()
        
        adoptScale()
    }
    
    func makeCoordinator() -> Coordinator {
        @Bindable var value = toolManager
        return Coordinator(
            drawingChanged: $drawingChanged,
            toolPicker: $toolPicker,
            objectRecognitionEnabled: $value.objectRecognitionEnabled,
            strokeCount: $strokeCount
        )
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
        
        if  page.color == "pagewhite" ||  page.color == "white" ||  page.color == "pageyellow" ||  page.color == "yellow"{
            cs = .light
        }
        
        return cs
    }
    
    func adoptScale() {
        canvasView.minimumZoomScale = scale
        canvasView.maximumZoomScale = scale
        
        canvasView.setZoomScale(scale, animated: false)
    }
    
}
