//
//  ShapeStyleView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 20.10.23.
//

import SwiftUI

struct ShapeStyleView: View {
    @Environment(ToolManager.self) var toolManager
    
    @State var fill: Color = .black
    @State var stroke: Color = .black
    
    var body: some View {
        @Bindable var item = toolManager.activeItem!.shape!
        
        Form {
            Section {
                Toggle("Füllung", isOn: $item.fill.animation())
                    .tint(Color.accentColor)
                    .frame(height: 30)
                
                if item.fill {
                    ColorPicker("Farbe", selection: $fill, supportsOpacity: true)
                        .frame(height: 30)
                }
            }
            
            Section {
                Toggle("Rahmen", isOn: $item.stroke.animation())
                    .tint(Color.accentColor)
                    .frame(height: 30)
                
                if item.stroke {
                    ColorPicker("Farbe", selection: $stroke, supportsOpacity: true)
                        .frame(height: 30)
                    
                    HStack {
                        Stepper("", value: $item.strokeWidth)
                            .labelsHidden()
                        
                        Spacer()
                        
                        TextField(
                            "Breite", value: $item.strokeWidth, formatter: NumberFormatter()
                        )
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 75)
                    }
                    .frame(height: 30)
                }
            }
        }
        .environment(\.defaultMinListRowHeight, 10)
        .onChange(of: stroke) {
            item.strokeColor = stroke.data()
        }
        .onChange(of: fill) {
            item.fillColor = fill.data()
        }
        .onAppear {
            fill = Color(data: item.fillColor)
            stroke = Color(data: item.strokeColor)
        }
    }
}
