//
//  ShapeBarView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 31.10.23.
//

import SwiftUI

struct ShapeBarView: View {
    @Environment(ToolManager.self) var toolManager
    
    @State var showLine: Bool = false
    
    @AppStorage("hsidebarposition")
    var hsPosition: HSPosition = .leading
    
    @AppStorage("vsidebarposition")
    var vsPosition: VSPosition = .top
    
    var axis: Axis
    var body: some View {
        if toolManager.activeItem != nil {
            @Bindable var shape = toolManager.activeItem!.shape!
            
            Group {
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
                Divider().padding(15)
                Spacer()
                
                SidebarToggle(isOn: $shape.stroke) {
                    Image(systemName: "square")
                }
                .modifier(SICFrame(axis: axis))
                
                if shape.stroke {
                    SidebarColorPicker(color: $shape.strokeColor)
                        .modifier(SICFrame(axis: axis))
                    
                    SidebarButton(action: { showLine.toggle() }) {
                        Image(systemName: "lineweight")
                            .popover(isPresented: $showLine) {
                                Text("hello")
                                    .padding()
                            }
                    }
                    .modifier(SICFrame(axis: axis))
                }
                
                Spacer()
                Divider().padding(15)
                Spacer()
                
                SidebarButton(action: {}) {
                    Image(systemName: "house")
                }
                .modifier(SICFrame(axis: axis))
                
                SidebarButton(action: {}) {
                    Image(systemName: "house")
                }
                .modifier(SICFrame(axis: axis))
                
                SidebarButton(action: {}) {
                    Image(systemName: "house")
                }
                .modifier(SICFrame(axis: axis))
                
                Spacer()
                Divider().padding(15)
                Spacer()
                
                SidebarButton(action: {}) {
                    Image(systemName: "house")
                }
                .modifier(SICFrame(axis: axis))
                
                SidebarButton(action: {}) {
                    Image(systemName: "house")
                }
                .modifier(SICFrame(axis: axis))
                
                SidebarButton(action: {}) {
                    Image(systemName: "house")
                }
                .modifier(
                    SICFrame(
                        axis: axis,
                        alignment: axis == .vertical ? .leading : .top
                    )
                )
            }
            .animation(.bouncy, value: shape.stroke)
            
            
        }
    }
}
