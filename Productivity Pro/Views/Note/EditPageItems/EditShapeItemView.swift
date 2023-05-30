//
//  EditShapeItem.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.03.5.3.53.
//

import SwiftUI

struct EditShapeItemView: View {
    
    @Binding var document: Productivity_ProDocument
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    @State var editShapeModel: EditShapeModel = EditShapeModel()
    
    var body: some View {
        
        let itemIndex = document.document.note.pages[
            toolManager.selectedPage
        ].items.firstIndex(where: { $0.id == toolManager.selectedItem?.id })
        
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
                    .onChange(of: editShapeModel.strokeWidth) { _ in
                        if editShapeModel.strokeWidth < 1 {
                            editShapeModel.strokeWidth = 1
                        } else if editShapeModel.strokeWidth > 1000 {
                            editShapeModel.strokeWidth = 1000
                        }
                    }
                }
            }
            if let index = itemIndex {
                if document.document.note.pages[
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
                            .onChange(of: editShapeModel.cornerRadius) { _ in
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
            Section("Arrange") {
                FormSpacer {
                    HStack {
                        TextField(
                            "Rotation", value: $editShapeModel.rotation, format: .number
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
                    .onChange(of: editShapeModel.rotation) { _ in
                        if editShapeModel.rotation < 0 {
                            editShapeModel.rotation = 0
                        } else if editShapeModel.rotation > 360 {
                            editShapeModel.rotation = 360
                        }
                    }
                }
                
                FormSpacer {
                    HStack {
                        Button(action: { moveUp() }) {
                            Image(systemName: "square.2.stack.3d.top.filled")
                        }
                        .buttonStyle(.bordered)
                        
                        Button(action: { moveDown() }) {
                            Image(systemName: "square.2.stack.3d.bottom.filled")
                        }
                        .buttonStyle(.bordered)
                        
                        Spacer()
                        Divider().frame(height: 30)
                        Spacer()
                        
                        Button(action: { moveHighest() }) {
                            Image(systemName: "square.3.stack.3d.top.filled")
                        }
                        .buttonStyle(.bordered)
                        
                        Button(action: { moveLowest() }) {
                            Image(systemName: "square.3.stack.3d.bottom.filled")
                        }
                        .buttonStyle(.bordered)
                    }
                }
            }
            
        }
        .formStyle(.grouped)
#if targetEnvironment(macCatalyst)
        .scrollContentBackground(.hidden)
#endif
        .onChange(of: editShapeModel) { _ in
            onEditModelChange(itemIndex: itemIndex)
        }
        .onAppear { onAppear() }
    }
    
    func moveUp() {
        
        let index = document.document.note.pages[
            toolManager.selectedPage
        ].items.firstIndex(
            where: { $0.id == toolManager.selectedItem?.id }
        )!
        
        if index + 1 != document.document.note.pages[
            toolManager.selectedPage
        ].items.count {
            document.document.note.pages[
                toolManager.selectedPage
            ].items.move(toolManager.selectedItem!, to: index + 1)
        }
    }
    
    func moveDown() {
        
        let index = document.document.note.pages[
            toolManager.selectedPage
        ].items.firstIndex(
            where: { $0.id == toolManager.selectedItem?.id }
        )!
        
        if index != 0 {
            document.document.note.pages[
                toolManager.selectedPage
            ].items.move(toolManager.selectedItem!, to: index - 1)
        }
    }
    
    func moveHighest() {
        
        let lastIndex = document.document.note.pages[
            toolManager.selectedPage
        ].items.firstIndex(
            where: { $0.id == document.document.note.pages[
                toolManager.selectedPage
            ].items.last!.id }
        )!
        
        document.document.note.pages[
            toolManager.selectedPage
        ].items.move(toolManager.selectedItem!, to: lastIndex)
    }
    
    func moveLowest() {
        
        let firstIndex = document.document.note.pages[
            toolManager.selectedPage
        ].items.firstIndex(
            where: { $0.id == document.document.note.pages[
                toolManager.selectedPage
            ].items.first!.id }
        )!
        
        document.document.note.pages[
            toolManager.selectedPage
        ].items.move(toolManager.selectedItem!, to: firstIndex)
    }
    
    func onAppear() {
        
        let selectedItem = document.document.note.pages[
            toolManager.selectedPage
        ].items.first(where: { $0.id == toolManager.selectedItem?.id })
        
        if let item = selectedItem {
            if let shape = item.shape {
                editShapeModel = EditShapeModel(
                    rotation: item.rotation,
                    showFill: shape.showFill,
                    fillColor: Color(codable: shape.fillColor)!,
                    showStroke: shape.showStroke,
                    strokeColor: Color(codable: shape.strokeColor)!,
                    strokeWidth: shape.strokeWidth,
                    cornerRadius: shape.cornerRadius
                )
            }
        }
        
    }
    
    func onEditModelChange(itemIndex: Int?) {
        if let index = itemIndex {
            
            document.document.note.pages[
                toolManager.selectedPage
            ].items[index].shape?.showFill = editShapeModel.showFill
            
            document.document.note.pages[
                toolManager.selectedPage
            ].items[index].shape?.fillColor = editShapeModel.fillColor.toCodable()
            
            document.document.note.pages[
                toolManager.selectedPage
            ].items[index].shape?.showStroke = editShapeModel.showStroke
            
            document.document.note.pages[
                toolManager.selectedPage
            ].items[index].shape?.strokeColor = editShapeModel.strokeColor.toCodable()
            
            document.document.note.pages[
                toolManager.selectedPage
            ].items[index].shape?.strokeWidth = editShapeModel.strokeWidth
            
            document.document.note.pages[
                toolManager.selectedPage
            ].items[index].shape?.cornerRadius = editShapeModel.cornerRadius
            
            document.document.note.pages[
                toolManager.selectedPage
            ].items[index].rotation = editShapeModel.rotation
            
            toolManager.selectedItem = document.document.note.pages[
                toolManager.selectedPage
            ].items[index]
        }
    }
    
}

struct EditShapeModel: Equatable {
    var rotation: Double = 0
    
    var showFill: Bool = true
    var fillColor: Color = .primary
    
    var showStroke: Bool = false
    var strokeColor: Color = .accentColor
    
    var strokeWidth: Double = 5
    
    var cornerRadius: Double = 10
}
