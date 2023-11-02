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
    
    @State var showLine: Bool = false
    
    @AppStorage("hsidebarposition")
    var hsPosition: HSPosition = .leading
    
    @AppStorage("vsidebarposition")
    var vsPosition: VSPosition = .top
    
    var axis: Axis
    var body: some View {
        if toolManager.activeItem != nil {
            @Bindable var shape = toolManager.activeItem!.shape!
            
            SidebarToggle(isOn: $shape.fill) {
                Image(systemName: "square.fill")
            }
            .modifier(
                SICFrame(
                    axis: axis,
                    alignment: axis == .vertical ? .trailing : .bottom
                )
            )
            
            SidebarColorPicker(color: $shape.fillColor)
                .modifier(SICFrame(axis: axis))
                .disabled(shape.fill == false)
            
            Spacer()
            Divider()
                .padding(.vertical, axis == .vertical ? 15 : 5)
                .padding(.horizontal, axis == .horizontal ? 15 : 5)
            Spacer()
            
            SidebarToggle(isOn: $shape.stroke) {
                Image(systemName: "square")
            }
            .modifier(SICFrame(axis: axis))
            
            SidebarColorPicker(color: $shape.strokeColor)
                .disabled(shape.stroke == false)
                .modifier(SICFrame(axis: axis))
            
            SidebarButton(action: { showLine.toggle() }) {
                Image(systemName: "lineweight")
                    .disabled(shape.stroke == false)
                    .popover(isPresented: $showLine) {
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
            
            if shape.type == PPShapeType.rectangle.rawValue {
                SidebarButton(action: {}) {
                    Image(systemName: "angle")
                }
                .modifier(SICFrame(axis: axis))
            }
            
            SidebarButton(action: {}) {
                Image(systemName: "arrow.2.circlepath")
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
            
            if hsc == .regular {
                SidebarButton(action: {}) {
                    Image(systemName: "square.2.stack.3d.top.fill")
                }
                .modifier(SICFrame(axis: axis))
                
                SidebarButton(action: {}) {
                    Image(systemName: "square.2.stack.3d.bottom.filled")
                }
                .modifier(SICFrame(axis: axis))
                
                SidebarButton(action: {}) {
                    Image(systemName: "square.3.stack.3d.top.fill")
                }
                .modifier(SICFrame(axis: axis))
                
                SidebarButton(action: {}) {
                    Image(systemName: "square.3.stack.3d.bottom.fill")
                }
                .modifier(
                    SICFrame(
                        axis: axis,
                        alignment: axis == .vertical ? .leading : .top
                    )
                )
                
            } else {
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
}
