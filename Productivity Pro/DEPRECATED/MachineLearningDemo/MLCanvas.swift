//
//  MLCanvas.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 12.01.26.
//

import SwiftUI
import PencilKit

struct CanvasView: UIViewRepresentable {
    @Bindable var model: MLViewModel
    
    func makeUIView(context: Context) -> PKCanvasView  {
        model.canvas.delegate = context.coordinator
        
        model.canvas.drawingPolicy = .pencilOnly
        model.canvas.backgroundColor = UIColor.white
        
        model.canvas.tool = PKInkingTool(
            ink: PKInk(.monoline, color: .black),
            width: 3
        )
        
        return model.canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(model: model)
    }
    
    class Coordinator: NSObject, PKCanvasViewDelegate {
       @Bindable var model: MLViewModel
        
        init(model: MLViewModel) {
            self.model = model
        }
        
        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            if model.isReplacing == false {
                model.predict(for: canvasView)
            }
        }
    }
}
