//
//  DrawingViewMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.06.23.
//

import PencilKit
import SwiftUI

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
    
    func didSelectedPageChange() {
        pkCanvasView.isRulerActive = false
        pkToolPicker.setVisible(
            false, forFirstResponder: pkCanvasView
        )
        
        pkToolPicker.removeObserver(pkCanvasView)
        pkCanvasView.resignFirstResponder()
        
        toolManager.pencilKit = false
    }
    
    func didCanvasAvailabilityChange(_ isEnabled: Bool) {
        if isEnabled {
            pkToolPicker.setVisible(true, forFirstResponder: pkCanvasView)
            
            pkToolPicker.addObserver(pkCanvasView)
            pkCanvasView.becomeFirstResponder()
        } else {
            disableCanvasAvailability()
            page.canvas = pkCanvasView.drawing.dataRepresentation()
        }
    }
    
    func disableCanvasAvailability() {
        pkCanvasView.isRulerActive = false
        
        pkToolPicker.setVisible(false, forFirstResponder: pkCanvasView)
        
        pkToolPicker.removeObserver(pkCanvasView)
        pkCanvasView.resignFirstResponder()
    }
    
    func getFrame() -> CGSize {
        if page.isPortrait {
            return CGSize(width: shortSide, height: longSide)
        } else {
            return CGSize(width: longSide, height: shortSide)
        }
    }
}
