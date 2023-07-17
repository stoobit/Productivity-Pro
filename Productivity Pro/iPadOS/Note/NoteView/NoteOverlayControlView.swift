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
    
    var size: CGSize
    var isCPMenuHidden: Bool
    
    var body: some View {
        ZStack {
            
            if subviewManager.isPresentationMode {
                LaserpointerView()
            }
            
            if toolManager.isPageNumberVisible {
                IndicatorText(
                    document: document, toolManager: toolManager
                )
            }
            
            CopyPasteMenuView(
                document: $document,
                toolManager: toolManager,
                subviewManager: subviewManager
            )
            .offset(y: isCPMenuHidden ? 100 : 0)
            .animation(
                .easeInOut(duration: 0.2),
                value: isCPMenuHidden
            )
            
        }
        .frame(height: size.height)
    }
}
