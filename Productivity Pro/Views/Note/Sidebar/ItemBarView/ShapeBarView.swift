//
//  ShapeBarView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 31.10.23.
//

import SwiftUI
import PPAnglePicker

struct ShapeBarView: View {
    @Environment(ToolManager.self) var toolManager
    @Environment(\.horizontalSizeClass) var hsc
    
    @AppStorage("hsidebarposition")
    var hsPosition: HSPosition = .leading
    
    @AppStorage("vsidebarposition")
    var vsPosition: VSPosition = .top
    
    @State var lineWidth: Bool = false
    @State var rotation: Bool = false
    @State var position: Bool = false
    
    var axis: Axis
    var body: some View {
        if toolManager.activeItem != nil {
            @Bindable var shape = toolManager.activeItem!.shape!
            
            SidebarButton(action: { }) {
                Image(systemName: "chevron.left")
            }
            .modifier(
                SICFrame(
                    axis: axis,
                    alignment: axis == .vertical ? .trailing : .bottom
                )
            )
            
            Spacer()
            Divider()
                .padding(.vertical, axis == .vertical ? 15 : 5)
                .padding(.horizontal, axis == .horizontal ? 15 : 5)
            Spacer()
            
            SidebarToggle(isOn: $shape.fill) {
                Image(systemName: "circle.fill")
            }
            .modifier(SICFrame(axis: axis))
            
            SidebarColorPicker(color: $shape.fillColor)
                .modifier(SICFrame(axis: axis))
                .disabled(shape.fill == false)
            
            Spacer()
            Divider()
                .padding(.vertical, axis == .vertical ? 15 : 5)
                .padding(.horizontal, axis == .horizontal ? 15 : 5)
            Spacer()
            
            SidebarToggle(isOn: $shape.stroke) {
                Image(systemName: "circle")
            }
            .modifier(SICFrame(axis: axis))
            
            SidebarColorPicker(color: $shape.strokeColor)
                .disabled(shape.stroke == false)
                .modifier(SICFrame(axis: axis))
            
            SidebarButton(action: { lineWidth.toggle() }) {
                Image(systemName: "lineweight")
                    .disabled(shape.stroke == false)
                    .popover(isPresented: $lineWidth) {
                        Text("hello")
                            .padding()
                    }
            }
            .modifier(SICFrame(axis: axis))
            
            Spacer()
            Divider()
                .padding(.vertical, axis == .vertical ? 15 : 5)
                .padding(.horizontal, axis == .horizontal ? 15 : 5)
            Spacer()
            
            SidebarButton(action: {}) {
                Image(systemName: "square")
            }
            .modifier(SICFrame(axis: axis))
            .disabled(shape.type != PPShapeType.rectangle.rawValue)
            
            SidebarButton(action: { rotation.toggle() }) {
                Image(systemName: "angle")
                    .popover(isPresented: $rotation) {
                        PPAnglePickerView(degrees: $shape.rotation)
                            .frame(width: 280, height: 280)
                    }
            }
            .modifier(SICFrame(axis: axis))
            
            SidebarButton(action: {}) {
                Image(systemName: "lock.fill")
            }
            
            Spacer()
            Divider()
                .padding(.vertical, axis == .vertical ? 15 : 5)
                .padding(.horizontal, axis == .horizontal ? 15 : 5)
            Spacer()
            
            SidebarButton(action: {}) {
                Image(systemName: "square.stack.3d.up")
            }
            .modifier(
                SICFrame(
                    axis: axis,
                    alignment: axis == .vertical ? .leading : .top
                )
            )
        }
    }
}
