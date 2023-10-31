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
    
    var axis: Axis
    var body: some View {
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
        
        Spacer()
        Divider().padding(15)
        Spacer()
        
        SidebarToggle(isOn: $shape.stroke) {
            Image(systemName: "square")
        }
        .modifier(SICFrame(axis: axis))
        
        SidebarColorPicker(color: $shape.strokeColor)
            .modifier(SICFrame(axis: axis))
        
        SidebarButton(action: { showLine.toggle() }) {
            Image(systemName: "lineweight")
        }
        .modifier(SICFrame(axis: axis))
        .popover(isPresented: $showLine) {
            Text("hello")
                .padding()
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
}
