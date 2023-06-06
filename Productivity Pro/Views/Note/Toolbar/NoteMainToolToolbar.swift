//
//  NoteCustomizableToolbar.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.09.22.
//

import SwiftUI

struct NoteMainToolToolbar: CustomizableToolbarContent {
    @Environment(\.undoManager) var undoManager
    @Environment(\.openWindow) var openWindow
    
    @AppStorage("defaultFont") var defaultFont: String = "Avenir Next"
    @AppStorage("defaultFontSize") var defaultFontSize: Double = 12
    
    @Binding var document: Productivity_ProDocument
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    var body: some CustomizableToolbarContent {
        
        ToolbarItem(id: "markup", placement: .secondaryAction) {
            Button(action: {
                
                toolManager.isCanvasEnabled.toggle()
                toolManager.selectedItem = nil
                toolManager.isLocked = false
                
            }) {
                Label(
                    "Markup",
                    systemImage: toolManager.isCanvasEnabled ? "pencil.tip.crop.circle.fill" : "pencil.tip.crop.circle"
                )
            }
        }
        
        ToolbarItem(id: "shapes", placement: .secondaryAction) {
            Menu(content: {
                Section {
                    Button(action: { addShape(type: .rectangle) }) {
                        Label("Rectangle", systemImage: "rectangle")
                    }
                    
                    Button(action: { addShape(type: .circle) }) {
                        Label("Circle", systemImage: "circle")
                    }
                    
                    Button(action: { addShape(type: .triangle) }) {
                        Label("Triangle", systemImage: "triangle")
                    }
                    
                    Button(action: { addShape(type: .hexagon) }) {
                        Label("Hexagon", systemImage: "hexagon")
                    }
                }
                
            }) {
                Label("Shape", systemImage: "square.on.circle")
            }
            
        }
        
        ToolbarItem(id: "textbox", placement: .secondaryAction) {
            Button(action: { addTextField() }) {
                Label("Text Box", systemImage: "character.textbox")
            }
        }
        
        ToolbarItem(id: "media", placement: .secondaryAction) {
            Menu(content: {
                
                Section {
                    Button(action: {
                        toolManager.isCanvasEnabled = false
                        subviewManager.showCameraView.toggle()
                    }) {
                        Label("Camera", systemImage: "camera")
                    }
                    
                    Button(action: {
                        toolManager.isCanvasEnabled = false
                        subviewManager.showImportPhoto.toggle()
                    }) {
                        Label("Photos", systemImage: "photo.on.rectangle")
                    }
                }
                
                Button(action: {
                    toolManager.isCanvasEnabled = false
                    subviewManager.showImportMedia.toggle()
                }) {
                    Label("Browse Files", systemImage: "folder")
                }
                
            }) {
                Label("Media", systemImage: "photo")
            }
            .modifier(
                ImportMediaHelper(
                    toolManager: toolManager,
                    subviewManager: subviewManager,
                    document: $document
                )
            )
            
        }
        
//        ToolbarItem(id: "calc", placement: .secondaryAction) {
//            Button(action: { openWindow(id: "calculator") }) {
//                Label("Calculator", systemImage: "x.squareroot")
//            }
//        }
        
    }
}
