//
//  TitleShareButton.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 07.06.23.
//

import SwiftUI

struct TitleShareButton: View {
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    let sharePDF: () -> Void
    
    var body: some View {
        
        if #available(iOS 17, *) {
            
            Button(action: {
                toolManager.isCanvasEnabled = false
                sharePDF()
            }) {
                
                Label("Export as PDF", systemImage: "doc")
                
            }
            
        } else {
            Menu(content: {
                
                Button("Productivity Pro") {
                    toolManager.isCanvasEnabled = false
                    subviewManager.sharePPSheet = true
                }
                Button("PDF") {
                    toolManager.isCanvasEnabled = false
                    sharePDF()
                }
                
            }) {
                Label("Share", systemImage: "square.and.arrow.up.on.square")
            }
        }
    }
}
