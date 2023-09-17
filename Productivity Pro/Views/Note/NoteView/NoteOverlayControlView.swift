//
//  NoteOverlayControlView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.06.23.
//

import SwiftUI

struct NoteOverlayControlView: View {
    
    @Binding var document: Document
    
    @Bindable var toolManager: ToolManager
    @Bindable var subviewManager: SubviewManager
    @Bindable var drawingModel: PPDrawingModel 
    
    var size: CGSize
    var isCPMenuHidden: Bool
    
    var body: some View {
        ZStack {
           
            if toolManager.isPageNumberVisible {
                IndicatorText(
                    document: document, toolManager: toolManager
                )
            }
            
            PPToolbar(
                document: $document,
                toolManager: toolManager,
                subviewManager: subviewManager,
                drawingModel: drawingModel,
                size: size
            )
            
        }
        .frame(width: size.width, height: size.height)
    }
}
