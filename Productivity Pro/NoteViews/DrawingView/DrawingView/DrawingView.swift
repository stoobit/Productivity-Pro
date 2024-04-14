//
//  DrawingView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 15.04.23.
//

import PencilKit
import SwiftUI

struct DrawingView: View {
    @Environment(ToolManager.self) var toolManager
    @Environment(\.scenePhase) var scenePhase
    
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
        .onChange(of: toolManager.activePage) { disableCanvas() }
        .onChange(of: toolManager.pencilKit) {
            setCanvas()
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active { becameForeground() }
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
