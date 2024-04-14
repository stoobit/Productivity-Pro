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
            pkToolPicker.setVisible(true, forFirstResponder: pkCanvasView)
            
            pkToolPicker.addObserver(pkCanvasView)
            pkCanvasView.becomeFirstResponder()
        }
    }
    
    func setCanvas() {
        if toolManager.pencilKit {
            pkToolPicker.setVisible(true, forFirstResponder: pkCanvasView)
            pkToolPicker.addObserver(pkCanvasView)
            
            pkCanvasView.becomeFirstResponder()
        } else {
            disableCanvas()
        }
    }
    
    func disableCanvas() {
        pkCanvasView.isRulerActive = false
        pkToolPicker.setVisible(
            false, forFirstResponder: pkCanvasView
        )
        
        pkToolPicker.removeObserver(pkCanvasView)
        pkCanvasView.resignFirstResponder()
        
        toolManager.pencilKit = false
    }
    
    func getFrame() -> CGSize {
        if page.isPortrait {
            return CGSize(width: shortSide, height: longSide)
        } else {
            return CGSize(width: longSide, height: shortSide)
        }
    }
}
