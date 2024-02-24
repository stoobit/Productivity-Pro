//
//  PKCoordinator.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.12.23.
//

import SwiftUI
import PencilKit

final class Coordinator: NSObject, PKCanvasViewDelegate {
    var update: Bool = true
    
    @Binding var drawingChanged: Bool
    @Binding var toolPicker: PKToolPicker
    
    @Binding var strokeCount: Int
    
    init(
        drawingChanged: Binding<Bool>,
        toolPicker: Binding<PKToolPicker>,
        strokeCount: Binding<Int>
    ) {
        _drawingChanged = drawingChanged
        _toolPicker = toolPicker
        _strokeCount = strokeCount
    }
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        Task { @MainActor in
            if update {
                update = false
                drawingChanged = true
                
                strokeCount = canvasView.drawing.strokes.count
                update = true
            }
        }
    }
}
