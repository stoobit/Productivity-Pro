//
//  EditTextfieldItemView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.02.23.
//

import SwiftUI

struct EditTextfieldItemView: View {
    
    @Binding var document: Document
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    @State var editTextFieldModel = EditTextFieldModel()
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
        .onChange(of: editTextFieldModel) { _ in
            onEditModelChange()
        }
        .onAppear { onAppear() }
        
    }
    
    @ViewBuilder func StyleView() -> some View {
        Form {
            Section("Text Style") {
                FormSpacer {
                    Picker("Font", selection: $editTextFieldModel.font) {
                        ForEach(UIFont.familyNames, id: \.self) { font in
                            Text(font)
                                .tag(font)
                        }
                    }
                }
                
                FormSpacer {
                    HStack {
                        
                        ColorPicker("Color", selection: $editTextFieldModel.fontColor, supportsOpacity: true)
                            .labelsHidden()
                        
                        Spacer()
                        
                        TextField(
                            "Size", value: $editTextFieldModel.fontSize, format: .number
                        )
                        .keyboardType(.decimalPad)
                        .frame(width: 85)
                        .textFieldStyle(.roundedBorder)
                        
                        Stepper(
                            "",
                            value: $editTextFieldModel.fontSize,
                            in: 1...1000, step: 1
                        )
                        .labelsHidden()
                        .padding(.leading)
                    }
                    .onChange(of: editTextFieldModel.fontSize) { _ in
                        if editTextFieldModel.fontSize < 1 {
                            editTextFieldModel.fontSize = 1
                        } else if editTextFieldModel.fontSize > 1000 {
                            editTextFieldModel.fontSize = 1000
                        }
                    }
                }
            }
            
            Section("Fill Style") {
                
                FormSpacer {
                    Toggle("Show Fill", isOn: $editTextFieldModel.showFill.animation())
                        .tint(.accentColor)
                }
                
                if editTextFieldModel.showFill {
                    FormSpacer {
                        ColorPicker("Color", selection: $editTextFieldModel.fillColor, supportsOpacity: true)
                    }
                }
            }
            
            Section("Border Style") {
                FormSpacer {
                    Toggle("Show Border", isOn: $editTextFieldModel.showStroke.animation())
                        .tint(.accentColor)
                }
                
                if editTextFieldModel.showStroke {
                    FormSpacer {
                        HStack {
                            ColorPicker("", selection: $editTextFieldModel.strokeColor, supportsOpacity: true)
                                .labelsHidden()
                            
                            Spacer()
                            
                            TextField(
                                "Width", value: $editTextFieldModel.strokeWidth, format: .number
                            )
                            .keyboardType(.decimalPad)
                            .frame(width: 85)
                            .textFieldStyle(.roundedBorder)
                            
                            Stepper(
                                "",
                                value: $editTextFieldModel.strokeWidth,
                                in: 1...1000, step: 1
                            )
                            .labelsHidden()
                            .padding(.leading)
                        }
                    }
                    .onChange(of: editTextFieldModel.strokeWidth) { _ in
                        if editTextFieldModel.strokeWidth < 1 {
                            editTextFieldModel.strokeWidth = 1
                        } else if editTextFieldModel.strokeWidth > 1000 {
                            editTextFieldModel.strokeWidth = 1000
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder func ArrangeView() -> some View {
        Form {
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
                
            Section {
                FormSpacer {
                    HStack {
                        Text("Center")
                        Spacer()
                        Button(action: { center() }) {
                            Image(
                                systemName: document.note.pages[
                                    toolManager.selectedPage
                                ].isPortrait ? "rectangle.portrait.center.inset.filled" : "rectangle.center.inset.filled"
                            )
                        }
                        .buttonStyle(.bordered)
                        .hoverEffect(.lift)
                    }
                }
                FormSpacer {
                    HStack {
                        Text("Lock")
                        Spacer()
                        .buttonStyle(.bordered)
                        .hoverEffect(.lift)
                        
                        Button(action: {
                            editTextFieldModel.isLocked.toggle()
                        }) {
                            Image(
                                systemName: editTextFieldModel.isLocked ? "lock.fill" : "lock"
                            )
                        }
                        .disabled(disableLock())
                        .buttonStyle(.bordered)
                        .hoverEffect(.lift)
                    }
                }
            }
        }
    }
    
}

