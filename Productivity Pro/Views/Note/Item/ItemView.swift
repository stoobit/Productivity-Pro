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
    
    @State var editItemModel: EditItemModel = .init()
    
    @Bindable var note: PPNoteModel
    @Bindable var page: PPPageModel
    
    @Bindable var item: ItemObserver
    @Binding var scale: CGFloat
    
    var realrenderText: Bool
    var preloadModels: Bool
    
    init(
        note: PPNoteModel,
        page: PPPageModel,
        item: PPItemModel,
        scale: Binding<CGFloat>,
        realrenderText: Bool,
        preloadModels: Bool
    ) {
        self.note = note
        self.page = page
        self.realrenderText = realrenderText
        self.preloadModels = preloadModels
        
        _scale = scale
        self.item = ItemObserver(item: item)
    }
    
    var body: some View {
        @Bindable var item = item.item
        
        if preloadModels {
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
                        highRes: realrenderText
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
                .zIndex(Double(page.items!.count + 20))
                .environment(editItemModel)
        }
    }
    
    func setEditModel() {
        editItemModel.position = CGPoint(
            x: item.item.x, y: item.item.y
        )
        editItemModel.size = CGSize(
            width: item.item.width, height: item.item.height
        )
    }
}
