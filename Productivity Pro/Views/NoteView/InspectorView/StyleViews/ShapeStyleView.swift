//
//  ShapeStyleView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 20.10.23.
//

import SwiftUI

struct ShapeStyleView: View {
    @Environment(ToolManager.self) var toolManager
    
    @State var fill: Bool = true
    @State var stroke: Bool = false
    @State var fillColor: Color = .black
    @State var strokeColor: Color = .black
    @State var strokeWidth: Bool = false
    @State var cornerRadius: Bool = false
    
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
            
            if item.type == PPShapeType.rectangle.rawValue {
                Section("Ecken") {
                    HStack {
                        Text("Radius")
                        
                        Spacer()
                        
                        Button(String(item.cornerRadius)) {
                            cornerRadius.toggle()
                        }
                        .ppDoubleKeyboard(
                            isPresented: $cornerRadius,
                            value: $item.cornerRadius
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
        .onChange(of: stroke) {
            toolManager.activePage?.store(activeItem) {
                item.stroke = stroke
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
        .onChange(of: strokeColor) {
            toolManager.activePage?.store(activeItem) {
                item.strokeColor = strokeColor.data()
                toolManager.update += 1
             
                return activeItem
            }
        }
        .onChange(of: item.cornerRadius) {
            toolManager.activePage?.store(activeItem) {
                toolManager.update += 1
                return activeItem
            }
        }
        .onAppear {
            fill = item.fill
            stroke = item.stroke
            fillColor = Color(data: item.fillColor)
            strokeColor = Color(data: item.strokeColor)
        }
    }
}
