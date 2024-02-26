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
    
    @State var vuModel: VUModel = .init()
    
    @Bindable var note: PPNoteModel
    @Bindable var page: PPPageModel
    @Bindable var item: PPItemModel
    
    @Binding var scale: CGFloat
    
    var realrenderText: Bool
    var preloadModels: Bool
    
    var body: some View {
        if preloadModels {
            vuModel.setModel(from: item)
        }
        
        return Group {
            Group {
                if item.type == PPItemType.shape.rawValue {
                    ShapeItemView(
                        item: item,
                        editItem: vuModel,
                        scale: $scale
                    )
                } else if item.type == PPItemType.textField.rawValue {
                    TextFieldItemView(
                        item: item,
                        editItem: vuModel,
                        scale: $scale,
                        highRes: realrenderText
                    )
                } else if item.type == PPItemType.media.rawValue {
                    MediaItemView(
                        item: item,
                        editItem: vuModel,
                        scale: $scale
                    )
                }
            }
            .modifier(VUModifier(vuModel: vuModel, item: item))
            .position(
                x: (vuModel.position.x) * scale,
                y: (vuModel.position.y) * scale
            )
            .modifier(
                DragItemModifier(
                    item: item, page: page,
                    editItemModel: vuModel,
                    scale: $scale
                )
            )
            
            ToolView(page: page, item: item, vuModel: vuModel, scale: $scale)
                .zIndex(Double(page.items!.count + 20))
        }
    }
}
