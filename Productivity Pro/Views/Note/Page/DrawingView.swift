//
//  DrawingView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 18.07.23.
//

import SwiftUI

struct DrawingView: View {
    
    @Binding var page: Page
    
    @Bindable var toolManager: ToolManager
    @Bindable var subviewManager: SubviewManager
    
    var pdfRendering: Bool
    var size: CGSize
    
    var body: some View {
        PencilKitViewWrapper(
            size: size,
            page: $page,
            toolManager: toolManager,
            subviewManager: subviewManager
        )
        .zIndex(Double(page.items.count + 10))
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
