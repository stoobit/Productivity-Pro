//
//  EditTextfieldItemView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.02.23.
//

import SwiftUI

struct EditTextfieldItemView: View {
    
    @Binding var document: ProductivityProDocument
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    @State var editTextFieldModel: EditTextFieldModel = EditTextFieldModel()
    
    var body: some View {
        
        let itemIndex = document.document.note.pages[
            toolManager.selectedPage
        ].items.firstIndex(where: { $0.id == toolManager.selectedItem?.id })
        
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
                    Toggle("Fill", isOn: $editTextFieldModel.showFill.animation())
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
            Section("Arrange") {
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
                
                FormSpacer {
                    HStack {
                        Text("Center Box")
                        Spacer()
                        Button(action: { center() }) {
                            Image(
                                systemName: document.document.note.pages[
                                    toolManager.selectedPage
                                ].isPortrait ? "rectangle.portrait.center.inset.filled" : "rectangle.center.inset.filled"
                            )
                        }
                        .buttonStyle(.bordered)
                    }
                }
            }
            
        }
        .onChange(of: editTextFieldModel) { _ in
            
            if let index = itemIndex {
                
                document.document.note.pages[
                    toolManager.selectedPage
                ].items[index].textField?.showFill = editTextFieldModel.showFill
                
                document.document.note.pages[
                    toolManager.selectedPage
                ].items[index].textField?.fillColor = editTextFieldModel.fillColor.toCodable()
                
                document.document.note.pages[
                    toolManager.selectedPage
                ].items[index].textField?.showStroke = editTextFieldModel.showStroke
                
                document.document.note.pages[
                    toolManager.selectedPage
                ].items[index].textField?.strokeColor = editTextFieldModel.strokeColor.toCodable()
                
                document.document.note.pages[
                    toolManager.selectedPage
                ].items[index].textField?.strokeWidth = editTextFieldModel.strokeWidth
                
                document.document.note.pages[
                    toolManager.selectedPage
                ].items[index].textField?.font = editTextFieldModel.font
                
                document.document.note.pages[
                    toolManager.selectedPage
                ].items[index].textField?.fontSize = editTextFieldModel.fontSize
                
                document.document.note.pages[
                    toolManager.selectedPage
                ].items[index].textField?.fontColor = editTextFieldModel.fontColor.toCodable()
                
                toolManager.selectedItem = document.document.note.pages[
                    toolManager.selectedPage
                ].items[index]
                
            }
        }
        .onAppear {
            
            let selectedItem = document.document.note.pages[
                toolManager.selectedPage
            ].items.first(where: { $0.id == toolManager.selectedItem?.id })
            
            if let item = selectedItem {
                if let textField = item.textField {
                    editTextFieldModel = EditTextFieldModel(
                        text: textField.text,
                        showFill: textField.showFill,
                        fillColor: Color(codable: textField.fillColor)!,
                        showStroke: textField.showStroke,
                        strokeColor: Color(codable: textField.strokeColor)!,
                        strokeWidth: textField.strokeWidth,
                        font: textField.font,
                        fontColor: Color(codable: textField.fontColor)!,
                        fontSize: textField.fontSize
                    )
                }
            }
        }
        
    }
    
    func center() {
        
        let itemIndex = document.document.note.pages[
            toolManager.selectedPage
        ].items.firstIndex(
            where: { $0.id == toolManager.selectedItem?.id }
        )
        
        if let index = itemIndex {
            document.document.note.pages[
                toolManager.selectedPage
            ].items[index].width = getFrame().width - 100
            document.document.note.pages[
                toolManager.selectedPage
            ].items[index].height = getFrame().height - 100
            
            document.document.note.pages[
                toolManager.selectedPage
            ].items[index].x = getFrame().width / 2
            
            document.document.note.pages[
                toolManager.selectedPage
            ].items[index].y = getFrame().height / 2
        }
        
        if let id = toolManager.selectedItem?.id {
         
            toolManager.selectedItem = nil
            toolManager.selectedItem = document.document.note.pages[
                toolManager.selectedPage
            ].items.first(where: { $0.id == id })
            
            subviewManager.showStylePopover = false   
        }
        
    }
    
    func getFrame() -> CGSize {
        let page = document.document.note.pages[toolManager.selectedPage]
        
        var frame: CGSize = .zero
        
        if page.isPortrait {
            frame = CGSize(
                width: shortSide,
                height: longSide
            )
        } else {
            frame = CGSize(width: longSide, height: shortSide)
        }
        
        return frame
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
    
}

struct EditTextFieldModel: Equatable {
    var text: String = ""
    
    var showFill: Bool = true
    var fillColor: Color = .primary
    
    var showStroke: Bool = false
    var strokeColor: Color = .accentColor
    
    var strokeWidth: Double = 5
    
    var font: String = "Avenir Next"
    var fontColor: Color = .black
    var fontSize: Double = 12
    
}
