//
//  PageItemView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 08.02.23.
//

import SwiftUI

struct PageItemView: View {
    
    @Binding var document: Productivity_ProDocument
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
}
