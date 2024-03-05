//
//  MediaStyleView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 20.10.23.
//

import SwiftUI

struct MediaStyleView: View {
    @Environment(ToolManager.self) var toolManager
    
    @State var stroke: Bool = false
    @State var strokeColor: Color = .black
    @State var strokeWidth: Bool = false
    @State var cornerRadius: Bool = false
    
    var body: some View {
        @Bindable var item = toolManager.activeItem!.media!
        @Bindable var activeItem = toolManager.activeItem!
        
        Form {
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
        .environment(\.defaultMinListRowHeight, 10)
        .onChange(of: strokeColor) {
            toolManager.activePage?.store(activeItem) {
                item.strokeColor = strokeColor.data()
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
        .onChange(of: item.cornerRadius) {
            toolManager.activePage?.store(activeItem) {
                toolManager.update += 1
                return activeItem
            }
        }
        .onChange(of: item.strokeWidth) {
            toolManager.activePage?.store(activeItem) {
                toolManager.update += 1
                return activeItem
            }
        }
        .onAppear {
            stroke = item.stroke
            strokeColor = Color(data: item.strokeColor)
        }
    }
}
