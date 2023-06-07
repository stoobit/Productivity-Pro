//
//  PageItemView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 08.02.23.
//

import SwiftUI

struct PageItemView: View {
    
    @Binding var document: ProductivityProDocument
    @Binding var page: Page
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    var body: some View {
        ForEach($page.items) { $item in
            
            ItemView(
                document: $document,
                page: $page,
                item: $item,
                toolManager: toolManager,
                subviewManager: subviewManager
            )
            .onTapGesture {
                tap(item: item)
            }
            .zIndex(
                Double(page.items.firstIndex(where: { $0.id == item.id })!)
            )
            
        }
        .frame(
            width: toolManager.zoomScale * getFrame().width,
            height: toolManager.zoomScale * getFrame().height
        )
        .clipShape(Rectangle())
        .scaleEffect(1/toolManager.zoomScale)
    }
    
    func tap(item: ItemModel) {
        
        if item.type == .textField {
    
            if toolManager.selectedItem?.id == item.id {
                subviewManager.showTextEditor = true
                toolManager.selectedItem = item
            } else {
                toolManager.selectedItem = item
            }
            
        } else {
            toolManager.selectedItem = item
        }
    }
    
    func getFrame() -> CGSize {
        var frame: CGSize = .zero
        
        if page.isPortrait {
            frame = CGSize(width: shortSide, height: longSide)
        } else {
            frame = CGSize(width: longSide, height: shortSide)
        }
        
        return frame
    }
}
