//
//  ShapeArrangeView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.10.23.
//

import SwiftUI
import PPAnglePicker
import PPDoubleKeyboard

struct ShapeArrangeView: View {
    @Environment(ToolManager.self) var toolManager
    
    @State var anglePicker: Bool = false
    
    @State var xPos: Bool = false
    
    var hsc: UserInterfaceSizeClass?
    var body: some View {
        @Bindable var shape = toolManager.activeItem!.shape!
        @Bindable var item = toolManager.activeItem!
        
        Form {
            Section("Position") {
                HStack {
                    Text("X")
                    Spacer()
                    Button(String(item.x.rounded(toPlaces: 1))) {
                        xPos.toggle()
                    }
                    .ppDoubleKeyboard(isPresented: $xPos, value: $item.x)
                }
                .frame(height: 30)
                
                HStack {
                    Text("Y")
                    Spacer()
                    Button(String(item.y.rounded(toPlaces: 1))) {
                        
                    }
                }
                .frame(height: 30)
            }
            
            Section {
                HStack {
                    Button(action: { }) {
                        Image(systemName: "square.2.stack.3d.top.filled")
                    }
                    .buttonStyle(.bordered)
                    .hoverEffect(.lift)
                    
                    Button(action: {  }) {
                        Image(systemName: "square.2.stack.3d.bottom.filled")
                    }
                    .buttonStyle(.bordered)
                    .hoverEffect(.lift)
                    
                    Spacer()
                    Divider().frame(height: 20)
                    Spacer()
                    
                    Button(action: {  }) {
                        Image(systemName: "square.3.stack.3d.top.filled")
                    }
                    .buttonStyle(.bordered)
                    .hoverEffect(.lift)
                    
                    Button(action: {  }) {
                        Image(systemName: "square.3.stack.3d.bottom.filled")
                    }
                    .buttonStyle(.bordered)
                    .hoverEffect(.lift)
                }
                .frame(height: 30)
            }
            .listSectionSpacing(10)
            
            Section("Dimensionen") {
                HStack {
                    Text("Breite")
                    Spacer()
                    Button(String(item.width.rounded(toPlaces: 1))) {
                        
                    }
                }
                .frame(height: 30)
                
                HStack {
                    Text("Höhe")
                    Spacer()
                    Button(String(item.height.rounded(toPlaces: 1))) {
                        
                    }
                }
                .frame(height: 30)
            }
            
            Section {
                HStack {
                    Text("Drehung")
                    Spacer()
                    Button(action: { anglePicker.toggle() }) {
                        Text("\(String(shape.rotation))°")
                    }
                    .popover(isPresented: $anglePicker) {
                        PPAnglePickerView(
                            degrees: $shape.rotation
                        )
                        .presentationCompactAdaptation(.popover)
                        .frame(width: 270, height: 270)
                        .background {
                            Color(
                                UIColor.secondarySystemBackground
                            )
                            .ignoresSafeArea(.all)
                        }
                    }
                }
                .frame(height: 30)
            }
            .listSectionSpacing(10)
        }
        .environment(\.defaultMinListRowHeight, 10)
    }
}
