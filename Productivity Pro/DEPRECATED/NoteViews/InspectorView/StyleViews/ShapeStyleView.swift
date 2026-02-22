//
//  ShapeStyleView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 20.10.23.
//

import SwiftUI

struct ShapeStyleView: View {
    @Bindable var toolManager: ToolManager
    
    @State var fill: Bool
    @State var fillColor: Color
    @State var stroke: Bool
    @State var strokeColor: Color
    @State var strokeWidth: Double
    @State var cornerRadius: Double
    
    @State var radiusPicker: Bool = false
    @State var strokePicker: Bool = false
    
    init(toolManager: ToolManager) {
        self.toolManager = toolManager
        let item = toolManager.activeItem!.shape!
        
        _fill = State(initialValue: item.fill)
        _fillColor = State(initialValue: Color(data: item.fillColor))
        
        _stroke = State(initialValue: item.stroke)
        _strokeColor = State(initialValue: Color(data: item.strokeColor))
        _strokeWidth = State(initialValue: item.strokeWidth)
        
        _cornerRadius = State(initialValue: item.cornerRadius)
    }
    
    var body: some View {
        @Bindable var item = toolManager.activeItem!.shape!
        @Bindable var activeItem = toolManager.activeItem!
        
        Form {
            Section("Füllung") {
                Toggle(isOn: $fill.animation()) {
                    Image(systemName: "square.fill")
                        .foregroundStyle(Color.primary)
                }
                .tint(Color.accentColor)
                .frame(height: 30)
            }
             
            if fill {
                Section {
                    ColorPicker("Farbe", selection: $fillColor, supportsOpacity: true)
                        .frame(height: 30)
                }
                .listSectionSpacing(10)
            }
            
            Section("Rahmen") {
                Toggle(isOn: $stroke.animation()) {
                    Image(systemName: "square")
                        .foregroundStyle(Color.primary)
                }
                .tint(Color.accentColor)
                .frame(height: 30)
            }
                
            if stroke {
                Section {
                    ColorPicker("Farbe", selection: $strokeColor, supportsOpacity: false)
                        .frame(height: 30)
                    
                    HStack {
                        Text("Breite")
                        
                        Spacer()
                        
                        Button(String(item.strokeWidth)) {
                            strokePicker.toggle()
                        }
                        .ppDoubleKeyboard(
                            isPresented: $strokePicker,
                            value: $strokeWidth
                        )
                    }
                    .frame(height: 30)
                }
                .listSectionSpacing(10)
            }
            
            if item.type == PPShapeType.rectangle.rawValue {
                Section("Ecken") {
                    HStack {
                        Text("Radius")
                        
                        Spacer()
                        
                        Button(String(item.cornerRadius)) {
                            radiusPicker.toggle()
                        }
                        .ppDoubleKeyboard(
                            isPresented: $radiusPicker,
                            value: $cornerRadius
                        )
                    }
                    .frame(height: 30)
                }
                .listSectionSpacing(10)
            }
        }
        .environment(\.defaultMinListRowHeight, 10)
        .onChange(of: fill) {
            toolManager.activePage?.store(activeItem) {
                item.fill = fill
                toolManager.update += 1
                
                return activeItem
            }
        }
        .onChange(of: fillColor) {
            toolManager.activePage?.store(activeItem) {
                item.fillColor = fillColor.data()
                toolManager.update += 1
             
                return activeItem
            }
        }
        .onChange(of: stroke) {
            toolManager.activePage?.store(activeItem) {
                item.stroke = stroke
                toolManager.update += 1
                
                return activeItem
            }
        }
        .onChange(of: strokeColor) {
            toolManager.activePage?.store(activeItem) {
                item.strokeColor = strokeColor.data()
                toolManager.update += 1
             
                return activeItem
            }
        }
        .onChange(of: strokeWidth) {
            toolManager.activePage?.store(activeItem) {
                item.strokeWidth = strokeWidth
                toolManager.update += 1
             
                return activeItem
            }
        }
        .onChange(of: cornerRadius) {
            toolManager.activePage?.store(activeItem) {
                item.cornerRadius = cornerRadius
                toolManager.update += 1
                
                return activeItem
            }
        }
    }
}
