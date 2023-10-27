//
//  ToolView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 16.01.23.
//

import SwiftUI

struct ToolView: View {
    @Environment(ToolManager.self) var toolManager
    @Environment(SubviewManager.self) var subviewManager
    @Environment(EditItemModel.self) var editItemModel
    
    var page: PPPageModel
    var item: PPItemModel
    
    @GestureState var width: Double? = nil
    @GestureState var height: Double? = nil
    
    @State var zPositioning: CGSize = .zero
    @Binding var scale: CGFloat
    
    var body: some View {
        if item.id == toolManager.activeItem?.id {
            ZStack {
                if toolManager.frameVisible {
                   FrameView()
                }
                
                if toolManager.editorVisible && toolManager.activeItem?.isLocked != true {
                    
                    if (toolManager.dragType == .none || toolManager.dragType == .size) &&
                        toolManager.activeItem?.type != PPItemType.textField.rawValue {
                      ResizeView()
                    }
                    
                    if toolManager.dragType == .none || toolManager.dragType == .width {
                        WidthView()
                    }
                    
                    if toolManager.dragType == .none || toolManager.dragType == .height {
                       HeightView()
                    }
                }
            }
            .rotationEffect(Angle(degrees: getRotation()))
            .position(
                x: editItemModel.position.x * scale,
                y: editItemModel.position.y * scale
            )
            .frame(
                width: scale * getFrame().width,
                height: scale * getFrame().height
            )
            .clipShape(Rectangle())
            
            
        }
    }
    
    @ViewBuilder func ResizeView() -> some View {
        Group {
            Circle()
                .modifier(DragAnchor(color: .green))
                .offset(x: editItemModel.size.width/2 * scale,
                        y: editItemModel.size.height/2 * scale
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
    
    @ViewBuilder func WidthView() -> some View {
        Group {
            Circle()
                .modifier(DragAnchor(color: .blue))
                .offset(x: editItemModel.size.width/2 * scale, y: 0)
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
    
    @ViewBuilder func HeightView() -> some View {
        Group {
            Circle()
                .modifier(DragAnchor(color: .blue))
                .offset(x: 0, y: (editItemModel.size.height/2) * scale)
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
    
    @ViewBuilder func FrameView() -> some View {
        Color.clear
            .contentShape(Rectangle())
            .frame(width: 1, height: 1)
            .zIndex(-2)
            .overlay {
                Rectangle()
                    .frame(
                        width: editItemModel.size.width * scale,
                        height: editItemModel.size.height * scale
                    )
                    .foregroundColor(.clear)
                    .border(
                        toolManager.activeItem?.isLocked == true ? Color.orange : Color.blue,
                        width: 1
                    )
            }
    }
}
