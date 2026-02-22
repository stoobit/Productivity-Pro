//
//  DragItemModifier.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.02.23.
//

import SwiftUI

struct DragItemModifier: ViewModifier {
    @Environment(ToolManager.self) var toolManager
    @GestureState private var startLocation: CGPoint? = nil
    
    @Bindable var item: PPItemModel
    @Bindable var page: PPPageModel
    
    @Binding var position: CGPoint
    @Binding var scale: CGFloat
    
    func body(content: Content) -> some View {
        content
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if isActive {
                            toolManager.editorVisible = false
                            
                            var newLocation = startLocation ?? position
                            
                            newLocation.x += (value.translation.width * (1 / scale))
                            newLocation.y += (value.translation.height * (1 / scale))
                            
                            if newLocation.x > getBorder().width - 20, newLocation.x < getBorder().width + 20 {
                                position.x = getBorder().width
                                toolManager.showSnapper[0] = true
                            } else {
                                position.x = newLocation.x
                                toolManager.showSnapper[0] = false
                            }
                            
                            if newLocation.y > getBorder().height - 20, newLocation.y < getBorder().height + 20 {
                                position.y = getBorder().height
                                toolManager.showSnapper[1] = true
                            } else {
                                position.y = newLocation.y
                                toolManager.showSnapper[1] = false
                            }
                        }
                    }
                    .updating($startLocation) { _, startLocation, _ in
                        if isActive { startLocation = startLocation ?? position }
                    }
                    .onEnded { _ in
                        if isActive {
                            page.store(item) {
                                item.x = position.x
                                item.y = position.y
                                
                                return item
                            }
                            
                            toolManager.editorVisible = true
                            
                            toolManager.activeItem = item
                            toolManager.showSnapper = [false, false]
                        }
                    }
            )
    }
    
    var isActive: Bool {
        item.id == toolManager.activeItem?.id && !item.isLocked
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
