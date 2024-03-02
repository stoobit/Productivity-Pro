//
//  TextFieldStyleView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 20.10.23.
//

import SwiftUI

struct TextFieldStyleView: View {
    @Environment(ToolManager.self) var toolManager
    
    @State var fill: Bool = true
    @State var stroke: Bool = false
    @State var strokeWidth: Bool = false
    @State var fontSize: Bool = false
    
    @State var fillColor: Color = .black
    @State var strokeColor: Color = .black
    @State var fontColor: Color = .black
    
    var body: some View {
        @Bindable var item = toolManager.activeItem?
            .textField ?? PPTextFieldModel()
        
        Form {
            Section("Text") {
                Picker("Schriftart", selection: $item.fontName) {
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
                        fontSize.toggle()
                    }
                    .ppDoubleKeyboard(isPresented: $fontSize, value: $item.fontSize)
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
                            strokeWidth.toggle()
                        }
                        .ppDoubleKeyboard(
                            isPresented: $strokeWidth,
                            value: $item.strokeWidth
                        )
                    }
                    .frame(height: 30)
                }
                .listSectionSpacing(10)
            }
        }
        .environment(\.defaultMinListRowHeight, 10)
        .onChange(of: fillColor) {
            item.fillColor = fillColor.data()
            toolManager.update += 1
        }
        .onChange(of: strokeColor) {
            item.strokeColor = strokeColor.data()
            toolManager.update += 1
        }
        .onChange(of: fill) {
            item.fill = fill
            toolManager.update += 1
        }
        .onChange(of: stroke) {
            item.stroke = stroke
            toolManager.update += 1
        }
        .onChange(of: fontColor) {
            item.textColor = fontColor.data()
            toolManager.update += 1
        }
        .onChange(of: item.fontName) {
            toolManager.update += 1
        }
        .onChange(of: item.fontSize) {
            toolManager.update += 1
        }
        .onAppear {
            fill = item.fill
            stroke = item.stroke
            fillColor = Color(data: item.fillColor)
            strokeColor = Color(data: item.strokeColor)
            fontColor = Color(data: item.textColor)
        }
    }
}
