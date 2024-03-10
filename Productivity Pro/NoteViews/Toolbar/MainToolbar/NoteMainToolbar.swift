//
//  NoteMainToolbar.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.09.22.
//

import StoreKit
import SwiftUI

struct NoteMainToolbar: CustomizableToolbarContent {
    @Bindable var contentObject: ContentObject
    
    @AppStorage("defaultFont") var defaultFont: String = "Avenir Next"
    @AppStorage("defaultFontSize") var defaultFontSize: Double = 12
    @AppStorage("createdNotes") var createdNotes: Int = 0
    
    @Environment(ToolManager.self) var toolManager
    @Environment(SubviewManager.self) var subviewManager
    @Environment(\.horizontalSizeClass) var hsc
    
    var body: some CustomizableToolbarContent {
        if hsc == .regular {
            ToolbarItem(id: "canvas", placement: .secondaryAction) {
                PencilKitButton()
            }
            
            ToolbarItem(id: "shapes", placement: .secondaryAction) {
                ShapesButton()
            }
            
            ToolbarItem(id: "textbox", placement: .secondaryAction) {
                TextFieldButton()
            }
            
            ToolbarItem(id: "media", placement: .secondaryAction) {
                MediaButton()
            }
            
        } else {
            Group {
                ToolbarItem(id: "canvas", placement: .secondaryAction) {
                    Button("Apple Pencil", systemImage: "pencil.tip") {
                        toolManager.pencilKit.toggle()
                        toolManager.activeItem = nil
                    }
                }
                
                ToolbarItem(id: "insert", placement: .secondaryAction) {
                    Menu("Einfügen", systemImage: "plus.square") {
                        ShapesButton()
                        TextFieldButton()
                        MediaButton()
                    }
                }
            }
        }
    }
    
    func primaryColor() -> Color {
        let page = contentObject.note!.pages?.first(where: {
            $0.id == toolManager.activePage.id
        })
        
        guard let color = page?.color else {
            return Color.gray
        }
        
        if color == "pageblack" || color == "pagegray" {
            return Color.white
        } else {
            return Color.black
        }
    }
}
