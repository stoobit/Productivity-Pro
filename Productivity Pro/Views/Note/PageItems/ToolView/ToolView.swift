//
//  ToolView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 16.01.23.
//

import SwiftUI

struct ToolView: View {
    
    @Binding var page: Page
    @Binding var item: ItemModel
    
    @GestureState var width: Double? = nil
    @GestureState var height: Double? = nil
    
    @Bindable var toolManager: ToolManager
    @Bindable var editItemModel: EditItemModel
    
    @State var zPositioning: CGSize = .zero
    
    var body: some View {
        if item.id == toolManager.selectedItem?.id {
            ZStack {
                
                if toolManager.showFrame {
                    Color.clear
                        .contentShape(Rectangle())
                        .frame(width: 1, height: 1)
                        .zIndex(-2)
                        .overlay {
                            Rectangle()
                                .frame(
                                    width: editItemModel.size.width * toolManager.zoomScale,
                                    height: editItemModel.size.height * toolManager.zoomScale
                                )
                                .foregroundColor(.clear)
                                .border(
                                    toolManager.selectedItem?.isLocked == true ? Color.orange : Color.accentColor,
                                    width: 1
                                )
                        }
                }
                
                if toolManager.isEditorVisible &&
                    toolManager.selectedItem?.isLocked != true
                {
                    if (toolManager.dragType == .none || toolManager.dragType == .size) && toolManager.selectedItem?.type != .textField {
                        Group {
                            Circle()
                                .modifier(DragAnchor(color: .green))
                                .offset(x: editItemModel.size.width/2 * toolManager.zoomScale,
                                        y: editItemModel.size.height/2 * toolManager.zoomScale
                                )
                                .gesture(
                                    DragGesture(minimumDistance: 0)
                                        .onChanged { value in
                                            changeScale(value: value)
                                        }
                                        .onEnded { _ in
                                            item.width = editItemModel.size.width
                                            item.height = editItemModel.size.height
                                            
                                            toolManager.dragType = .none
                                        }
                                        .updating($width) { _, width, _ in
                                            width = width ?? editItemModel.size.width
                                        }
                                        .updating($height) { _, height, _ in
                                            height = height ?? editItemModel.size.height
                                        }
                                )
                        }
                        .zIndex(-1)
                    }
                    
                    if toolManager.dragType == .none || toolManager.dragType == .width {
                        Group {
                            Circle()
                                .modifier(DragAnchor(color: .accentColor))
                                .offset(x: editItemModel.size.width/2 * toolManager.zoomScale, y: 0)
                                .gesture(
                                    DragGesture(minimumDistance: 0)
                                        .onChanged { value in
                                            changeWidth(value: value)
                                        }
                                        .onEnded { _ in
                                            item.width = editItemModel.size.width
                                            toolManager.dragType = .none
                                        }
                                        .updating($width) { _, startLocation, _ in
                                            startLocation = startLocation ?? editItemModel.size.width
                                        }
                                )
                        }
                        .zIndex(zPositioning.width)
                    }
                    
                    if toolManager.dragType == .none || toolManager.dragType == .height {
                        Group {
                            Circle()
                                .modifier(DragAnchor(color: .accentColor))
                                .offset(x: 0, y: (editItemModel.size.height/2) * toolManager.zoomScale)
                                .gesture(
                                    DragGesture(minimumDistance: 0)
                                        .onChanged { value in
                                            changeHeight(value: value)
                                        }
                                        .onEnded { _ in
                                            item.height = editItemModel.size.height
                                            toolManager.dragType = .none
                                        }
                                        .updating($height) { _, startLocation, _ in
                                            startLocation = startLocation ?? item.height
                                        }
                                )
                        }
                        .zIndex(zPositioning.height)
                    }
                }
            }
            .rotationEffect(Angle(degrees: item.rotation))
            .position(
                x: editItemModel.position.x * toolManager.zoomScale,
                y: editItemModel.position.y * toolManager.zoomScale
            )
            .frame(
                width: toolManager.zoomScale * getFrame().width,
                height: toolManager.zoomScale * getFrame().height
            )
            .clipShape(Rectangle())
            .scaleEffect(1/toolManager.zoomScale)
            
        }
    }
    
}
