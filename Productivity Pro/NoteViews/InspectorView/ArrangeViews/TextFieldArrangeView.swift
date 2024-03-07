//
//  TextFieldArrangeView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.11.23.
//

import SwiftUI

struct TextFieldArrangeView: View {
    @Environment(ToolManager.self) var toolManager
    var items: [PPItemModel]
    
    @State var anglePicker: Bool = false
    
    @State var xPos: Bool = false
    @State var yPos: Bool = false
    @State var width: Bool = false
    @State var heigth: Bool = false
    
    var body: some View {
        @Bindable var textField = toolManager.activeItem!.textField!
        @Bindable var item = toolManager.activeItem!
        
        Form {
            Section("Allgemein") {
                HStack {
                    Text("Zentrieren")
                    Spacer()
                    Button(action: { center() }) {
                        Image(systemName: "rectangle.portrait.center.inset.filled")
                    }
                    .buttonStyle(.bordered)
                }
                .frame(height: 30)
                
                HStack {
                    Text("Sperre")
                    Spacer()
                    Button(action: {
                        toolManager.activeItem?.isLocked.toggle()
                    }) {
                        Image(systemName: toolManager.activeItem?.isLocked == true ? "lock.fill" : "lock")
                    }
                    .buttonStyle(.bordered)
                }
                .frame(height: 30)
            }
            
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
                        yPos.toggle()
                    }
                    .ppDoubleKeyboard(isPresented: $yPos, value: $item.y)
                }
                .frame(height: 30)
            }
            
            Section {
                HStack {
                    Button(action: {
                        StackingManager(items: items)
                            .moveUp(item: item)
                    }) {
                        Image(systemName: "square.2.stack.3d.top.filled")
                    }
                    .buttonStyle(.bordered)
                    .hoverEffect(.lift)
                    
                    Button(action: {
                        StackingManager(items: items)
                            .moveDown(item: item)
                    }) {
                        Image(systemName: "square.2.stack.3d.bottom.filled")
                    }
                    .buttonStyle(.bordered)
                    .hoverEffect(.lift)
                    
                    Spacer()
                    Divider().frame(height: 20)
                    Spacer()
                    
                    Button(action: {
                        StackingManager(items: items)
                            .bringFront(item: item)
                    }) {
                        Image(systemName: "square.3.stack.3d.top.filled")
                    }
                    .buttonStyle(.bordered)
                    .hoverEffect(.lift)
                    
                    Button(action: {
                        StackingManager(items: items)
                            .bringBack(item: item)
                    }) {
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
                        width.toggle()
                    }
                    .ppDoubleKeyboard(
                        isPresented: $width, value: $item.width
                    )
                }
                .frame(height: 30)
                
                HStack {
                    Text("Höhe")
                    Spacer()
                    Button(String(item.height.rounded(toPlaces: 1))) {
                        heigth.toggle()
                    }
                    .ppDoubleKeyboard(
                        isPresented: $heigth, value: $item.height
                    )
                }
                .frame(height: 30)
            }
            
            Section {
                HStack {
                    Text("Drehung")
                    Spacer()
                    Button(action: { anglePicker.toggle() }) {
                        Text("\(String(textField.rotation))°")
                    }
                    .popover(isPresented: $anglePicker) {
                        PPAnglePickerView(item: $textField.rotation)
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
    
    func center() {
        toolManager.activeItem?.width = getFrame().width - 100
        toolManager.activeItem?.height = getFrame().height - 100
        
        toolManager.activeItem?.x = getFrame().width / 2
        toolManager.activeItem?.y = getFrame().height / 2
    }
    
    func getFrame() -> CGSize {
        var frame: CGSize = .zero
        
        if toolManager.activePage?.isPortrait == true {
            frame = CGSize(width: shortSide, height: longSide)
        } else {
            frame = CGSize(width: longSide, height: shortSide)
        }
        
        return frame
    }
}
