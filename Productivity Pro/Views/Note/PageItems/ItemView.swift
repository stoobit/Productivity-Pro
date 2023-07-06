//
//  ItemView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 20.05.23.
//

import SwiftUI

struct ItemView: View {
    
    @Binding var document: ProductivityProDocument
    @Binding var offset: CGFloat
    
    @Binding var page: Page
    @Binding var item: ItemModel
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    @StateObject var editItemModel: EditItemModel = EditItemModel()
    
    var highRes: Bool
    var body: some View {
            Group {
                if item.type == .shape {
                    ShapeItemView(
                        item: $item,
                        toolManager: toolManager,
                        editItem: editItemModel
                    )
                } else if item.type == .textField {
                    TextFieldItemView(
                        item: $item,
                        page: $page,
                        toolManager: toolManager,
                        editItem: editItemModel,
                        offset: $offset,
                        highRes: highRes
                    )
                } else if item.type == .media {
                    MediaItemView(
                        item: $item,
                        page: $page,
                        toolManager: toolManager,
                        editItem: editItemModel
                    )
                }
            }
            .rotationEffect(Angle(degrees: item.rotation))
            .position(
                x: (editItemModel.position.x) * toolManager.zoomScale,
                y: (editItemModel.position.y) * toolManager.zoomScale
            )
            .modifier(
                DragItemModifier(
                    page: $page,
                    item: $item,
                    toolManager: toolManager,
                    editItemModel: editItemModel
                )
            )
            .onAppear {
                editItemModel.position = CGPoint(
                    x: item.x, y: item.y
                )
                editItemModel.size = CGSize(
                    width: item.width, height: item.height
                )
            }
            .onChange(of: item.x) { x in
                editItemModel.position.x = x
            }
            .onChange(of: item.y) { y in
                editItemModel.position.y = y
            }
            .onChange(of: item.width) { width in
                editItemModel.size.width = width
            }
            .onChange(of: item.height) { height in
                editItemModel.size.height = height
            }
            
            ToolView(
                page: $page,
                item: $item,
                toolManager: toolManager,
                editItemModel: editItemModel
            )
            .scaleEffect(toolManager.zoomScale)
            .zIndex(Double(page.items.count + 20))
        
    }
}
