//
//  TextFieldStyleView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 20.10.23.
//

import SwiftUI

struct TextFieldStyleView: View {
    @Bindable var toolManager: ToolManager
    
    @State var fill: Bool
    @State var fillColor: Color
    
    @State var stroke: Bool
    @State var strokeColor: Color
    @State var strokeWidth: Double
    
    @State var fontName: String
    @State var fontSize: Double
    @State var fontColor: Color
    
    @State var strokePicker: Bool = false
    @State var sizePicker: Bool = false
    
    init(toolManager: ToolManager) {
        self.toolManager = toolManager
        let item = toolManager.activeItem!.textField!
        
        _fill = State(initialValue: item.fill)
        _fillColor = State(initialValue: Color(data: item.fillColor))
        
        _stroke = State(initialValue: item.stroke)
        _strokeColor = State(initialValue: Color(data: item.strokeColor))
        _strokeWidth = State(initialValue: item.strokeWidth)
        
        _fontName = State(initialValue: item.fontName)
        _fontSize = State(initialValue: item.fontSize)
        _fontColor = State(initialValue: Color(data: item.textColor))
    }
    
    var body: some View {
        @Bindable var item = toolManager.activeItem?
            .textField ?? PPTextFieldModel()
        @Bindable var activeItem = toolManager.activeItem!
        
        Form {
            Section("Text") {
                Picker("Schriftart", selection: $fontName) {
                    ForEach(UIFont.familyNames, id: \.self) { font in
                        Text(font)
                            .tag(font)
                    }
                }
                .frame(height: 30)
                
                HStack {
                    Text("Schriftgröße")
                    
                    Spacer()
                    Button(String(item.fontSize)) {
                        sizePicker.toggle()
                    }
                    .ppDoubleKeyboard(
                        isPresented: $sizePicker, value: $fontSize
                    )
                }
                .frame(height: 30)
            }
            
            Section {
                ColorPicker("Schriftfarbe", selection: $fontColor, supportsOpacity: true)
                    .frame(height: 30)
            }
            .listSectionSpacing(10)
            
            Section("Füllung") {
                Toggle(isOn: $fill.animation()) {
                    Image(systemName: "square.fill")
                        .foregroundStyle(Color.primary)
                }
                .tint(Color.accentColor)
                .frame(height: 30)
            }
             
            if item.fill {
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
                
            if item.stroke {
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
        .onChange(of: fontName) {
            toolManager.activePage?.store(activeItem) {
                item.fontName = fontName
                toolManager.update += 1
                
                return activeItem
            }
        }
        .onChange(of: fontSize) {
            toolManager.activePage?.store(activeItem) {
                item.fontSize = fontSize
                toolManager.update += 1
                
                return activeItem
            }
        }
        .onChange(of: fontColor) {
            toolManager.activePage?.store(activeItem) {
                item.textColor = fontColor.data()
                toolManager.update += 1
                
                return activeItem
            }
        }
    }
}
