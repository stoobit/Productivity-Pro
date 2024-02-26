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
    
    @Bindable var page: PPPageModel
    @Bindable var item: PPItemModel
    
    @Bindable var vuModel: VUModel
    
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
                        toolManager.activeItem?.type != PPItemType.textField.rawValue
                    {
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
                x: vuModel.position.x * scale,
                y: vuModel.position.y * scale
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
            DragAnchor(color: .green)
                .offset(
                    x: (vuModel.size.width / 2) * scale,
                    y: (vuModel.size.height / 2) * scale
                )
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            changeScale(value: value)
                        }
                        .onEnded { _ in
                            item.width = vuModel.size.width
                            item.height = vuModel.size.height
                            
                            toolManager.dragType = .none
                        }
                        .updating($width) { _, width, _ in
                            width = width ?? vuModel.size.width
                        }
                        .updating($height) { _, height, _ in
                            height = height ?? vuModel.size.height
                        }
                )
        }
        .zIndex(-1)
    }
    
    @ViewBuilder func WidthView() -> some View {
        Group {
            DragAnchor(color: .main)
                .offset(x: vuModel.size.width / 2 * scale, y: 0)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            changeWidth(value: value)
                        }
                        .onEnded { _ in
                            item.width = vuModel.size.width
                            toolManager.dragType = .none
                        }
                        .updating($width) { _, startLocation, _ in
                            startLocation = startLocation ?? vuModel.size.width
                        }
                )
        }
        .zIndex(zPositioning.width)
    }
    
    @ViewBuilder func HeightView() -> some View {
        Group {
            DragAnchor(color: .main)
                .offset(x: 0, y: (vuModel.size.height / 2) * scale)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            changeHeight(value: value)
                        }
                        .onEnded { _ in
                            item.height = vuModel.size.height
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
                        width: vuModel.size.width * scale,
                        height: vuModel.size.height * scale
                    )
                    .foregroundColor(.clear)
                    .border(
                        toolManager.activeItem?.isLocked == true ? Color.orange : Color.main,
                        width: 1
                    )
            }
    }
}
