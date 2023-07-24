//
//  PPToolbar.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.07.23.
//

import SwiftUI

struct PPToolbar: View {
    @Environment(\.horizontalSizeClass) var hsc
    
    @Binding var document: ProductivityProDocument
    @State var pasteDisabled: Bool = false
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    @StateObject var drawingModel: PPDrawingModel
    
    var size: CGSize
    
    var showControls: Bool {
        if toolManager.isCanvasEnabled {
            return false
        } else {
            return true
        }
    }
    
    var ppDrawingOffset: CGFloat {
        let type = document.document.note.pages[
            toolManager.selectedPage
        ].canvasType
        
        if showControls == false && type == .ppDrawingKit {
            return 0
        } else {
            return 200
        }
    }
    
    var body: some View {
        ZStack {
            
            PPDrawingBar(
                drawingModel: drawingModel,
                toolManager: toolManager,
                hsc: hsc, size: size
            )
            .offset(x: 0, y: ppDrawingOffset)
            
            PPControlBar(
                document: $document,
                toolManager: toolManager,
                subviewManager: subviewManager
            )
            .offset(x: 0, y: showControls ? 0 : 200)
        
        }
        .animation(.spring(), value: showControls)
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .bottom
        )
        .padding(.bottom, 20)
        
    }
}
