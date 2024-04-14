//
//  DrawingViewRepresentable.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 16.04.23.
//

import PencilKit
import SwiftUI

@MainActor
struct PKRepresentable: UIViewRepresentable {
    @Environment(ToolManager.self) var toolManager
    
    @Bindable var page: PPPageModel
    @Binding var scale: CGFloat
    
    @Binding var canvasView: PKCanvasView
    @Binding var toolPicker: PKToolPicker
    
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
        }
        
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        if toolManager.editorVisible == false {
            toolPicker.isRulerActive = false
            canvasView.isRulerActive = false
        }
        
        canvasView.overrideUserInterfaceStyle = colorScheme()
        toolPicker.colorUserInterfaceStyle = colorScheme()
        
        adoptScale()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(page: page)
    }
    
    func getFrame() -> CGSize {
        if page.isPortrait {
            return CGSize(width: shortSide, height: longSide)
        } else {
            return CGSize(width: longSide, height: shortSide)
        }
    }
    
    func colorScheme() -> UIUserInterfaceStyle {
        var cs: UIUserInterfaceStyle = .dark
        
        if page.color == "pagewhite" ||
            page.color == "white" ||
            page.color == "pageyellow" ||
            page.color == "yellow"
        {
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
