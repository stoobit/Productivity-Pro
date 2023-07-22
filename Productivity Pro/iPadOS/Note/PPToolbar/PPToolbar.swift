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
    
    var body: some View {
        Group {
            
            if document.document.note.pages[
                toolManager.selectedPage
            ].canvasType == .ppDrawingKit {
                
                PPDrawingBar(
                    drawingModel: drawingModel,
                    toolManager: toolManager,
                    hsc: hsc, size: size
                )
                
            }
            
//            PPControlBar(
//                document: $document,
//                toolManager: toolManager,
//                subviewManager: subviewManager
//            )
        
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .bottom
        )
        .padding(.bottom, 20)
        
    }
}
