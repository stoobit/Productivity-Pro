//
//  DrawingViewMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.06.23.
//

import SwiftUI
import PencilKit

extension DrawingView {
    func becameForeground() {
        if toolManager.pencilKit {
            pkToolPicker.setVisible(
                true, forFirstResponder: pkCanvasView
            )
            
            pkToolPicker.addObserver(pkCanvasView)
            pkCanvasView.becomeFirstResponder()
        }
    }
    
    func didDrawingChange(_ value: Bool) {
        undoManager?.disableUndoRegistration()
        page.canvas = pkCanvasView.drawing.dataRepresentation()
        drawingChanged = false
        undoManager?.enableUndoRegistration()
        
        pkToolPicker.addObserver(pkCanvasView)
        pkCanvasView.becomeFirstResponder()
    }
    
    func didSelectedPageChange() {
        pkCanvasView.isRulerActive = false
        pkToolPicker.setVisible(
            false, forFirstResponder: pkCanvasView
        )
        
        pkToolPicker.removeObserver(pkCanvasView)
        pkCanvasView.resignFirstResponder()
        
        toolManager.isLocked = false
        toolManager.pencilKit = false
    }
    
    func didCanvasAvailabilityChange(_ isEnabled: Bool) {
        if isEnabled {
            pkToolPicker.setVisible(
                true, forFirstResponder: pkCanvasView
            )
            
            pkToolPicker.addObserver(pkCanvasView)
            pkCanvasView.becomeFirstResponder()
            
        } else {
            disableCanvasAvailability()
        }
    }
    
    func disableCanvasAvailability() {
        pkCanvasView.isRulerActive = false
        toolManager.isLocked = false
        
        pkToolPicker.setVisible(
            false, forFirstResponder: pkCanvasView
        )
        
        pkToolPicker.removeObserver(pkCanvasView)
        pkCanvasView.resignFirstResponder()
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
