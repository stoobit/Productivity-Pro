//
//  OverviewDragHelper.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 04.06.23.
//

import SwiftUI

struct DragAndDropPage: ViewModifier {
    
    @Binding var document: ProductivityProDocument
    
    let page: Page
    let type: OverviewListType
    
    @Binding var current: Page?
    @StateObject var toolManager: ToolManager
    
    func body(content: Content) -> some View {
        if type == .all {
            content
                .onDrag({
                    current = page
                    return NSItemProvider(contentsOf: URL(string: "\(page.id)")!)!
                })
                .onDrop(of: [.url],
                        delegate:
                            DragRelocateDelegate(
                                item: page,
                                listData: $document.document.note.pages,
                                current: $current, toolManager: toolManager
                            )
                )
            
        } else {
            content
        }
    }
}
