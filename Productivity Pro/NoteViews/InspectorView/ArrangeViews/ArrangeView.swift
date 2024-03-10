//
//  TextFieldArrangeView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.11.23.
//

import SwiftUI

struct ArrangeView: View {
    @Bindable var toolManager: ToolManager
    var items: [PPItemModel]
    
    @State var x: Double
    @State var y: Double
    @State var width: Double
    @State var height: Double
    @State var rotation: Double
    
    init(toolManager: ToolManager, items: [PPItemModel]) {
        self.toolManager = toolManager
        let item = toolManager.activeItem!
        
        _x = State(initialValue: item.x)
        _y = State(initialValue: item.y)
        _width = State(initialValue: item.width)
        _height = State(initialValue: item.height)
        
        if item.type == PPItemType.shape.rawValue {
            _rotation = State(initialValue: item.shape!.rotation)
        } else if item.type == PPItemType.media.rawValue {
            _rotation = State(initialValue: item.media!.rotation)
        } else if item.type == PPItemType.textField.rawValue {
            _rotation = State(initialValue: item.textField!.rotation)
        } else {
            _rotation = State(initialValue: 0)
        }
        
        self.items = items
    }
    
    @State var xPicker: Bool = false
    @State var yPicker: Bool = false
    @State var widthPicker: Bool = false
    @State var heigthPicker: Bool = false
    @State var anglePicker: Bool = false
    
    var body: some View {
        @Bindable var item = toolManager.activeItem!
        
        Form {
            GeneralView()
            
            Section("Position") {
                HStack {
                    Text("X")
                    Spacer()
                    Button(String(x.rounded(toPlaces: 1))) {
                        xPicker.toggle()
                    }
                    .ppDoubleKeyboard(isPresented: $xPicker, value: $x)
                }
                .frame(height: 30)
                
                HStack {
                    Text("Y")
                    Spacer()
                    Button(String(y.rounded(toPlaces: 1))) {
                        yPicker.toggle()
                    }
                    .ppDoubleKeyboard(isPresented: $yPicker, value: $y)
                }
                .frame(height: 30)
            }
            .onChange(of: x) {
                toolManager.activePage.store(item) {
                    item.x = x
                    return item
                }
            }
            .onChange(of: y) {
                toolManager.activePage.store(item) {
                    item.y = y
                    return item
                }
            }
            
            StackingView()
            
            Section("Dimensionen") {
                HStack {
                    Text("Breite")
                    Spacer()
                    Button(String(width.rounded(toPlaces: 1))) {
                        widthPicker.toggle()
                    }
                    .ppDoubleKeyboard(
                        isPresented: $widthPicker, value: $width
                    )
                }
                .frame(height: 30)
                
                HStack {
                    Text("Höhe")
                    Spacer()
                    Button(String(height.rounded(toPlaces: 1))) {
                        heigthPicker.toggle()
                    }
                    .ppDoubleKeyboard(
                        isPresented: $heigthPicker, value: $height
                    )
                }
                .frame(height: 30)
            }
            .onChange(of: width) {
                toolManager.activePage.store(item) {
                    item.width = width
                    return item
                }
            }
            .onChange(of: height) {
                toolManager.activePage.store(item) {
                    item.height = height
                    return item
                }
            }
            
            RotationView()
        }
        .environment(\.defaultMinListRowHeight, 10)
    }
    
    func center() {
        toolManager.activePage.store(toolManager.activeItem!) {
            toolManager.activeItem?.width = getFrame().width - 100
            toolManager.activeItem?.height = getFrame().height - 100
            
            toolManager.activeItem?.x = getFrame().width / 2
            toolManager.activeItem?.y = getFrame().height / 2
            
            return toolManager.activeItem!
        }
    }
    
    func getFrame() -> CGSize {
        var frame: CGSize = .zero
        
        if toolManager.activePage.isPortrait == true {
            frame = CGSize(width: shortSide, height: longSide)
        } else {
            frame = CGSize(width: longSide, height: shortSide)
        }
        
        return frame
    }
}
