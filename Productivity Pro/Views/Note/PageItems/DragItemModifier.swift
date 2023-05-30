//
//  DragItemModifier.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.02.23.
//

import SwiftUI

struct DragItemModifier: ViewModifier {
    
    @GestureState private var startLocation: CGPoint? = nil
    
    @Binding var page: Page
    @Binding var item: ItemModel
    
    @StateObject var toolManager: ToolManager
    @StateObject var editItemModel: EditItemModel
    
    func body(content: Content) -> some View {
        if item.id == toolManager.selectedItem?.id {
            
            content
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            toolManager.isEditorVisible = false
                            toolManager.isDraggingItem = true
                            
                            var newLocation = startLocation ?? editItemModel.position
                            
                            newLocation.x += (value.translation.width * (1/toolManager.zoomScale))
                            newLocation.y += (value.translation.height * (1/toolManager.zoomScale))
                            
                            if newLocation.x > getBorder().width - 20 && newLocation.x < getBorder().width + 20 {
                                editItemModel.position.x = getBorder().width
                                toolManager.showSnapper[0] = true
                            } else {
                                editItemModel.position.x = newLocation.x
                                toolManager.showSnapper[0] = false
                            }
                            
                            if newLocation.y > getBorder().height - 20 && newLocation.y < getBorder().height + 20 {
                                editItemModel.position.y = getBorder().height
                                toolManager.showSnapper[1] = true
                            } else {
                                editItemModel.position.y = newLocation.y
                                toolManager.showSnapper[1] = false
                            }
                            
                        }
                        .updating($startLocation) { (value, startLocation, transaction) in
                            startLocation = startLocation ?? editItemModel.position
                        }
                        .onEnded { value in
                            item.x = editItemModel.position.x
                            item.y = editItemModel.position.y
                            
                            toolManager.isEditorVisible = true
                            toolManager.isDraggingItem = false
                            
                            toolManager.selectedItem = item
                            toolManager.showSnapper = [false, false]
                        }
                )
            
        } else {
            content
        }
    }
    
    func getBorder() -> CGSize {
        var frame: CGSize = .zero
        
        if page.isPortrait {
            frame = CGSize(width: shortSide / 2, height: longSide / 2)
        } else {
            frame = CGSize(width: longSide / 2, height: shortSide / 2)
        }
        
        return frame
    }
    
}
