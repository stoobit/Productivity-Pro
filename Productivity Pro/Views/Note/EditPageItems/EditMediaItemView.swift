//
//  EditMediaItemView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.02.23.
//

import SwiftUI

struct EditMediaItemView: View {
    
    @Binding var document: ProductivityProDocument
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    @State var editMediaModel = EditMediaModel()
    @State var isStyleView: Bool = true
    
    var itemIndex: Int? {
        document.document.note.pages[
            toolManager.selectedPage
        ].items.firstIndex(where: {
            $0.id == toolManager.selectedItem?.id
        })
    }
    
    var body: some View {
        VStack(spacing: 0.0) {
            Picker("", selection: $isStyleView) {
                Text("Style").tag(true)
                Text("Arrange").tag(false)
            }
            .labelsHidden()
            .pickerStyle(.segmented)
            .padding()
            
            TabView(selection: $isStyleView) {
                StyleView()
                    .tag(true)
                
                ArrangeView()
                    .tag(false)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .background(Color("PopoverColor"))
        .onChange(of: editMediaModel) { _ in
            onEditModelChange()
        }
        .onAppear { onAppear() }
        
    }
    
    @ViewBuilder func StyleView() -> some View {
        Form {
            Section("Border Style") {
                FormSpacer {
                    Toggle("Show Border", isOn: $editMediaModel.showStroke.animation())
                        .tint(.accentColor)
                }
                
                if editMediaModel.showStroke {
                    FormSpacer {
                        HStack {
                            ColorPicker("", selection: $editMediaModel.strokeColor, supportsOpacity: true)
                                .labelsHidden()
                            
                            Spacer()
                            
                            TextField(
                                "Width", value: $editMediaModel.strokeWidth, format: .number
                            )
                            .keyboardType(.decimalPad)
                            .frame(width: 85)
                            .textFieldStyle(.roundedBorder)
                            
                            Stepper(
                                "",
                                value: $editMediaModel.strokeWidth,
                                in: 1...1000, step: 1
                            )
                            .labelsHidden()
                            .padding(.leading)
                        }
                    }
                    .onChange(of: editMediaModel.strokeWidth) { _ in
                        if editMediaModel.strokeWidth < 1 {
                            editMediaModel.strokeWidth = 1
                        } else if editMediaModel.strokeWidth > 1000 {
                            editMediaModel.strokeWidth = 1000
                        }
                    }
                }
            }
            
            Section("Corner Radius") {
                FormSpacer {
                    HStack {
                        TextField(
                            "Radius", value: $editMediaModel.cornerRadius, format: .number
                        )
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 85)
                        
                        Spacer()
                        
                        Stepper(
                            "",
                            value: $editMediaModel.cornerRadius,
                            in: 0...360, step: 1
                        )
                        .labelsHidden()
                    }
                    .onChange(of: editMediaModel.cornerRadius) { _ in
                        if editMediaModel.rotation < 0 {
                            editMediaModel.rotation = 0
                        } else if editMediaModel.rotation > 360 {
                            editMediaModel.rotation = 360
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder func ArrangeView() -> some View {
        Form {
            Section("Rotation") {
                FormSpacer {
                    HStack {
                        TextField(
                            "Degrees", value: $editMediaModel.rotation, format: .number
                        )
                        .keyboardType(.decimalPad)
                        .frame(width: 85)
                        .textFieldStyle(.roundedBorder)
                        
                        Spacer()
                        
                        Stepper(
                            "",
                            value: $editMediaModel.rotation,
                            in: 0...360, step: 1
                        )
                        .labelsHidden()
                        .padding(.leading)
                    }
                    .onChange(of: editMediaModel.rotation) { _ in
                        if editMediaModel.rotation < 0 {
                            editMediaModel.rotation = 0
                        } else if editMediaModel.rotation > 360 {
                            editMediaModel.rotation = 360
                        }
                    }
                }
            }
            
            Section("Position") {
                FormSpacer {
                    HStack {
                        Button(action: { moveUp() }) {
                            Image(systemName: "square.2.stack.3d.top.filled")
                        }
                        .buttonStyle(.bordered)
                        .hoverEffect(.lift)
                        
                        Button(action: { moveDown() }) {
                            Image(systemName: "square.2.stack.3d.bottom.filled")
                        }
                        .buttonStyle(.bordered)
                        .hoverEffect(.lift)
                        
                        Spacer()
                        Divider().frame(height: 30)
                        Spacer()
                        
                        Button(action: { moveHighest() }) {
                            Image(systemName: "square.3.stack.3d.top.filled")
                        }
                        .buttonStyle(.bordered)
                        .hoverEffect(.lift)
                        
                        Button(action: { moveLowest() }) {
                            Image(systemName: "square.3.stack.3d.bottom.filled")
                        }
                        .buttonStyle(.bordered)
                        .hoverEffect(.lift)
                    }
                }
            } 
        }
    }
}
