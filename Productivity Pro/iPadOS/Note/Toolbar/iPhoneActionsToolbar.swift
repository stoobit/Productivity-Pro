//
//  iPhoneActions.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 16.02.23.
//

import SwiftUI

struct iPhoneActionsToolbar: ToolbarContent {
    
    @Environment(\.undoManager) var undoManager
    @Environment(\.horizontalSizeClass) var hsc
    
    @Binding var document: ProductivityProDocument
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    var body: some ToolbarContent {
        
        ToolbarItemGroup(placement: .navigationBarLeading) {
            
            Menu(content: {
                
                Button("Productivity Pro") { subviewManager.sharePPSheet = true }
                Button("PDF") { subviewManager.sharePDFSheet = true }
                
            }) {
                Label("Share", systemImage: "square.and.arrow.up.on.square")
            }
            
            Button(action: { subviewManager.showPrinterView.toggle() }) {
                Label("Print", systemImage: "printer")
            }
            
        }
        
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            
            Button(action: {
                UITabBar.appearance().isHidden = false
                subviewManager.overviewSheet.toggle()
            }) {
                Label("Overview", systemImage: "square.grid.2x2")
            }
            
        }
        
    }
}
