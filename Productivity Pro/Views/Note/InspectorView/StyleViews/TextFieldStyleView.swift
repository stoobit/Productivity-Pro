//
//  TextFieldStyleView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 20.10.23.
//

import SwiftUI
import PPDoubleKeyboard

struct TextFieldStyleView: View {
    @Environment(ToolManager.self) var toolManager
    
    @State var fill: Bool = true
    @State var stroke: Bool = false
    @State var fillColor: Color = .black
    @State var strokeColor: Color = .black
    @State var strokeWidth: Bool = false
    
    var body: some View {
        @Bindable var item = toolManager.activeItem!.textField!
        
        Form {
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
        }
        .onChange(of: strokeColor) {
            item.strokeColor = strokeColor.data()
        }
        .onChange(of: fill) {
            item.fill = fill
        }
        .onChange(of: stroke) {
            item.stroke = stroke
        }
        .onAppear {
            fill = item.fill
            stroke = item.stroke
            fillColor = Color(data: item.fillColor)
            strokeColor = Color(data: item.strokeColor)
        }
    }
}
