//
//  NoteOverlayControlView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.06.23.
//

import SwiftUI

struct NoteOverlayControlView: View {
    
    @Binding var document: ProductivityProDocument
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    @StateObject var drawingModel: PPDrawingModel 
    
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
        .frame(height: size.height)
    }
}
