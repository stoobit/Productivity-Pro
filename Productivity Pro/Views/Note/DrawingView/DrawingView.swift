//
//  DrawingView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 15.04.23.
//

import SwiftUI
import PencilKit

struct DrawingView: View {
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.undoManager) var undoManager
    
    var size: CGSize
    
    @Binding var page: Page
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    @State var pkCanvasView: PKCanvasView = PKCanvasView()
    @State var pkToolPicker = PKToolPicker()
    
    @State var drawingChanged: Bool = false
    
    var body: some View {
        
        DrawingViewRepresentable(
            size: size,
            page: $page,
            toolManager: toolManager,
            subviewManager: subviewManager,
            canvasView: $pkCanvasView,
            toolPicker: $pkToolPicker,
            drawingChanged: $drawingChanged
        )
        .onChange(of: drawingChanged) { value in
            undoManager?.disableUndoRegistration()
            page.canvas = pkCanvasView.drawing.dataRepresentation()
            drawingChanged = false
            undoManager?.enableUndoRegistration()
        }
        .onChange(of: toolManager.selectedPage) { _ in
            pkCanvasView.isRulerActive = false
            pkToolPicker.setVisible(
                false, forFirstResponder: pkCanvasView
            )
            
            pkToolPicker.removeObserver(pkCanvasView)
            pkCanvasView.resignFirstResponder()
            
            toolManager.isLocked = false
            toolManager.isCanvasEnabled = false
            
        }
        .onChange(of: toolManager.isCanvasEnabled) { isEnabled in
            if isEnabled {
                pkToolPicker.setVisible(
                    true, forFirstResponder: pkCanvasView
                )
                
                pkToolPicker.addObserver(pkCanvasView)
                pkCanvasView.becomeFirstResponder()
                
            } else {
                pkCanvasView.isRulerActive = false
                toolManager.isLocked = false
                
                pkToolPicker.setVisible(
                    false, forFirstResponder: pkCanvasView
                )
                
                pkToolPicker.removeObserver(pkCanvasView)
                pkCanvasView.resignFirstResponder()
            }
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
    
}
