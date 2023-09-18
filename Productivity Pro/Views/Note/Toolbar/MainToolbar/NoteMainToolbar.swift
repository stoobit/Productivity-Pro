//
//  NoteCustomizableToolbar.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.09.22.
//

import SwiftUI
import StoreKit

struct NoteMainToolToolbar: CustomizableToolbarContent {
    @Environment(\.horizontalSizeClass) var hsc
    @Environment(\.openWindow) var openWindow
    
    @AppStorage("defaultFont")
    var defaultFont: String = "Avenir Next"
    
    @AppStorage("defaultFontSize")
    var defaultFontSize: Double = 12
    
    @AppStorage("createdNotes")
    var createdNotes: Int = 0
    
    @AppStorage("requestWasDone")
    var requestWasDone: Bool = false
    
    @Binding var document: Document
    
    @Bindable var toolManager: ToolManager
    @Bindable var subviewManager: SubviewManager
    
    var placement: ToolbarItemPlacement {
        hsc == .regular ? .secondaryAction : .bottomBar
    }
    
    var body: some CustomizableToolbarContent {
        
        ToolbarItem(id: "shapes", placement: .secondaryAction) {
            ShapesButton()
        }
        
        ToolbarItem(id: "textbox", placement: .secondaryAction) {
            MarkdownButton()
        }
        
        ToolbarItem(id: "media", placement: .secondaryAction) {
            MediaButton()
        }
        
        //            ToolbarItem(id: "calc", placement: .secondaryAction) {
        //                CalculatorButton()
        //            }
        
    }

    @ViewBuilder func ShapesButton() -> some View {
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
    
    @ViewBuilder func MarkdownButton() -> some View {
        Button(action: { addTextField() }) {
            Label("Text Box", systemImage: "character.textbox")
        }
    }
    
    @ViewBuilder func MediaButton() -> some View {
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
                    Label("Photos", systemImage: "photo.on.rectangle.angled")
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
    
    @ViewBuilder func CalculatorButton() -> some View {
        Button(action: { openWindow(id: "calculator") }) {
            Label("Calculator", systemImage: "x.squareroot")
        }
    }
    
}
