//
//  ItemView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 20.05.23.
//

import SwiftUI

struct ItemView: View {
    @Environment(ToolManager.self) var toolManager
    @Environment(SubviewManager.self) var subviewManager
    
    @State var editItemModel: EditItemModel = EditItemModel()
    
    var note: PPNoteModel
    var page: PPPageModel
    
    @Bindable var item: PPItemModel
    @Binding var scale: CGFloat
    
    var highResolution: Bool
    var pdfRendering: Bool
    
    var body: some View {
        
        if pdfRendering {
            self.setEditModel()
        }
        
        return Group {
            Group {
                if item.type == PPItemType.shape.rawValue {
                    
                    ShapeItemView(
                        item: item,
                        editItem: editItemModel,
                        scale: $scale
                    )
                    
                } else if item.type == PPItemType.textField.rawValue {
                    
                    TextFieldItemView(
                        item: item, 
                        editItem: editItemModel,
                        scale: $scale,
                        highRes: highResolution
                    )
                    
                } else if item.type == PPItemType.media.rawValue {
                    
                    MediaItemView(
                        item: item,
                        editItem: editItemModel,
                        scale: $scale
                    )
                    
                }
            }
            .position(
                x: (editItemModel.position.x) * scale,
                y: (editItemModel.position.y) * scale
            )
            .modifier(
                DragItemModifier(
                    item: item, page: page,
                    editItemModel: editItemModel,
                    scale: $scale
                )
            )
            .onAppear {
                setEditModel()
            }
            .onChange(of: item.x) {
                editItemModel.position.x = item.x
            }
            .onChange(of: item.y) {
                editItemModel.position.y = item.y
            }
            .onChange(of: item.width) {
                editItemModel.size.width = item.width
            }
            .onChange(of: item.height) {
                editItemModel.size.height = item.height
            }
            
            ToolView(page: page, item: item, scale: $scale)
                .scaleEffect(toolManager.zoomScale)
                .zIndex(Double(page.items!.count + 20))
                .environment(editItemModel)

        }
    }
    
    func setEditModel() {
        editItemModel.position = CGPoint(
            x: item.x, y: item.y
        )
        editItemModel.size = CGSize(
            width: item.width, height: item.height
        )
    }
}
