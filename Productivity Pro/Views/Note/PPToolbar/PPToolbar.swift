//
//  PPToolbar.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.07.23.
//

import SwiftUI

struct PPToolbar: View {
    @Environment(\.horizontalSizeClass) var hsc
    
    @Binding var document: Document
    @State var pasteDisabled: Bool = false
    
    @Bindable var toolManager: ToolManager
    @Bindable var subviewManager: SubviewManager
    @Bindable var drawingModel: PPDrawingModel
    
    @State var menu: Bool = false
    
    @AppStorage("CBPosition")
    private var CBPosition: Int = 0
    
    var size: CGSize
    
    var showControls: Bool {
        if toolManager.isCanvasEnabled {
            return false
        } else {
            return true
        }
    }
    
    var ppDrawingOffset: CGFloat {
        if document.note.pages.indices.contains(toolManager.selectedPage) {
            let type = document.note.pages[
                toolManager.selectedPage
            ].canvasType
            
            if showControls == false && type == .ppDrawingKit {
                return 0
            } else {
                return 200
            }
        }
        
        return 0
    }
    
    var body: some View {
        ZStack(alignment: alignment()) {
            
            PPDrawingBar(
                drawingModel: drawingModel,
                toolManager: toolManager,
                hsc: hsc, size: size, menu: $menu
            )
            .offset(x: 0, y: ppDrawingOffset)
            
            PPControlBar(
                document: $document,
                toolManager: toolManager,
                subviewManager: subviewManager
            )
            .offset(x: 0, y: (showControls && !subviewManager.isPresentationMode) ? 0 : 200)
        
        }
        .animation(.easeInOut(duration: 0.3), value: showControls)
        .animation(.easeInOut(duration: 0.3), value: subviewManager.isPresentationMode)
        .animation(.easeInOut(duration: 0.3), value: CBPosition)
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: alignment()
        )
        .padding(20)
        .onChange(of: showControls) { value in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                menu.toggle()
            }
        }
        .onChange(of: hsc) { _ in
            toolManager.isCanvasEnabled = false
        }
        
    }
    
    func alignment() -> Alignment {
        var alignment: Alignment = .bottom
        
        if CBPosition == 0 {
            alignment = .bottomLeading
        } else if CBPosition == 1 {
            alignment = .bottom
        } else if CBPosition == 2 {
            alignment = .bottomTrailing
        }
        
        return alignment
    }
}
