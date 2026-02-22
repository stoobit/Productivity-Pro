//
//  DrawingView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 15.04.23.
//

import PencilKit
import SwiftUI

struct DrawingView: View {
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.undoManager) var undoManager
    @Environment(ToolManager.self) var toolManager
    @Environment(SubviewManager.self) var subviewManager
    
    @Bindable var page: PPPageModel
    @Binding var scale: CGFloat
    
    @State var pkCanvasView: PKCanvasView = .init()
    @State var pkToolPicker = PKToolPicker()
    
    var body: some View {
        PKRepresentable(
            page: page, scale: $scale,
            canvasView: $pkCanvasView,
            toolPicker: $pkToolPicker
        )
        .zIndex(index)
        .onChange(of: toolManager.activePage) {
            didSelectedPageChange()
            disableCanvasAvailability()
            page.canvas = pkCanvasView.drawing.dataRepresentation()
        }
        .onChange(of: toolManager.pencilKit) {
            didCanvasAvailabilityChange(toolManager.pencilKit)
        }
        .onChange(of: scenePhase) { _, value in
            if value == .active {
                becameForeground()
            } else {
                page.canvas = pkCanvasView.drawing.dataRepresentation()
            }
        }
        .frame(
            width: scale * getFrame().width,
            height: scale * getFrame().height
        )
        .scaleEffect(1 / scale)
    }
    
    var index: Double {
        Double(page.items!.count + 10)
    }
}
