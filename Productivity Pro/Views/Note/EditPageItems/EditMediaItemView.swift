//
//  EditMediaItemView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.02.23.
//

import SwiftUI

struct EditMediaItemView: View {
    
    @Binding var document: Productivity_ProDocument
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    @State var editMediaModel: EditMediaModel = EditMediaModel()
    
    var body: some View {
        let itemIndex = document.document.note.pages[
            toolManager.selectedPage
        ].items.firstIndex(where: { $0.id == toolManager.selectedItem?.id })
        
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
            Section("Arrange") {
                FormSpacer {
                    HStack {
                        TextField(
                            "Rotation", value: $editMediaModel.rotation, format: .number
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
        .onChange(of: editMediaModel) { _ in
            
            if let index = itemIndex {
                
                document.document.note.pages[
                    toolManager.selectedPage
                ].items[index].media?.showStroke = editMediaModel.showStroke
                
                document.document.note.pages[
                    toolManager.selectedPage
                ].items[index].media?.strokeColor = editMediaModel.strokeColor.toCodable()
                
                document.document.note.pages[
                    toolManager.selectedPage
                ].items[index].media?.strokeWidth = editMediaModel.strokeWidth
                
                document.document.note.pages[
                    toolManager.selectedPage
                ].items[index].media?.cornerRadius = editMediaModel.cornerRadius
                
                document.document.note.pages[
                    toolManager.selectedPage
                ].items[index].rotation = editMediaModel.rotation
                
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
                if let media = item.media {
                    editMediaModel = EditMediaModel(
                        rotation: item.rotation,
                        showStroke: media.showStroke,
                        strokeColor: Color(codable: media.strokeColor)!,
                        strokeWidth: media.strokeWidth,
                        cornerRadius: media.cornerRadius
                    )
                }
            }
        }
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

struct EditMediaModel: Equatable {
    var rotation: Double = 0
    
    var showStroke: Bool = false
    var strokeColor: Color = .accentColor
    
    var strokeWidth: Double = 5
    var cornerRadius: Double = 10
}
