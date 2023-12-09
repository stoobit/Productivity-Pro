//
//  PKCoordinator.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.12.23.
//

import SwiftUI
import PencilKit

class Coordinator: NSObject, PKCanvasViewDelegate {
    var update: Bool = true
    
    @Binding var drawingChanged: Bool
    @Binding var toolPicker: PKToolPicker
    
    @Binding var objectRecognitionEnabled: Bool
    @Binding var strokeCount: Int
    
    init(
        drawingChanged: Binding<Bool>,
        toolPicker: Binding<PKToolPicker>,
        objectRecognitionEnabled: Binding<Bool>,
        strokeCount: Binding<Int>
    ) {
        _drawingChanged = drawingChanged
        _toolPicker = toolPicker
        _objectRecognitionEnabled = objectRecognitionEnabled
        _strokeCount = strokeCount
    }
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        Task { @MainActor in
            if update {
                update = false
                drawingChanged = true
                
                if objectRecognitionEnabled && strokeCount < canvasView.drawing.strokes.count {
                    recognizeObject(canvasView)
                }
                
                strokeCount = canvasView.drawing.strokes.count
                update = true
            }
        }
    }
    
    @objc 
    func recognizeObject(_ gestureRecognizer: UIGestureRecognizer) {
        print("recognition")
    }
}
