//
//  EditShapeItem.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.03.5.3.53.
//

import SwiftUI

struct EditShapeItemView: View {
    
    @Binding var document: Document
    
    @Bindable var toolManager: ToolManager
    @Bindable var subviewManager: SubviewManager
    
    @State var editShapeModel: EditShapeModel = EditShapeModel()
    @State var isStyleView: Bool = true
    
    var itemIndex: Int? {
        document.note.pages[
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
        .onChange(of: editShapeModel) {
            onEditModelChange(itemIndex: itemIndex)
        }
        .onAppear { onAppear() }
    }
    
    @ViewBuilder func StyleView() -> some View  {
        Form {
            Section("Fill Style") {
                FormSpacer {
                    Toggle("Show Fill", isOn: $editShapeModel.showFill.animation())
                        .tint(.accentColor)
                }
                
                if editShapeModel.showFill {
                    FormSpacer {
                        ColorPicker(
                            "Color",
                            selection: $editShapeModel.fillColor,
                            supportsOpacity: true
                        )
                    }
                }
            }
            
            Section("Border Style") {
                FormSpacer {
                    Toggle("Show Border", isOn: $editShapeModel.showStroke.animation())
                        .tint(.accentColor)
                }
                
                if editShapeModel.showStroke {
                    FormSpacer {
                        HStack {
                            ColorPicker("", selection: $editShapeModel.strokeColor, supportsOpacity: true)
                                .labelsHidden()
                            
                            Spacer()
                            
                            TextField(
                                "Width", value: $editShapeModel.strokeWidth, format: .number
                            )
                            .keyboardType(.decimalPad)
                            .frame(width: 85)
                            .textFieldStyle(.roundedBorder)
                            
                            Stepper(
                                "",
                                value: $editShapeModel.strokeWidth,
                                in: 1...1000, step: 1
                            )
                            .labelsHidden()
                            .padding(.leading)
                        }
                    }
                    .onChange(of: editShapeModel.strokeWidth) {
                        if editShapeModel.strokeWidth < 1 {
                            editShapeModel.strokeWidth = 1
                        } else if editShapeModel.strokeWidth > 1000 {
                            editShapeModel.strokeWidth = 1000
                        }
                    }
                }
            }
            
            if let index = itemIndex {
                if document.note.pages[
                    toolManager.selectedPage
                ].items[index].shape?.type == .rectangle {
                    
                    Section("Corner Radius") {
                        FormSpacer {
                            HStack {
                                TextField(
                                    "Radius", value: $editShapeModel.cornerRadius, format: .number
                                )
                                .keyboardType(.decimalPad)
                                .textFieldStyle(.roundedBorder)
                                .frame(width: 85)
                                
                                Spacer()
                                
                                Stepper(
                                    "",
                                    value: $editShapeModel.cornerRadius,
                                    in: 0...360, step: 1
                                )
                                .labelsHidden()
                            }
                            .onChange(of: editShapeModel.cornerRadius) {
                                if editShapeModel.rotation < 0 {
                                    editShapeModel.rotation = 0
                                } else if editShapeModel.rotation > 360 {
                                    editShapeModel.rotation = 360
                                }
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder func ArrangeView() -> some View  {
        Form {
            Section("Rotation") {
                FormSpacer {
                    HStack {
                        TextField(
                            "Degrees", value: $editShapeModel.rotation, format: .number
                        )
                        .keyboardType(.decimalPad)
                        .frame(width: 85)
                        .textFieldStyle(.roundedBorder)
                        
                        Spacer()
                        
                        Stepper(
                            "",
                            value: $editShapeModel.rotation,
                            in: 0...360, step: 1
                        )
                        .labelsHidden()
                        .padding(.leading)
                    }
                    .onChange(of: editShapeModel.rotation) {
                        if editShapeModel.rotation < 0 {
                            editShapeModel.rotation = 0
                        } else if editShapeModel.rotation > 360 {
                            editShapeModel.rotation = 360
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
