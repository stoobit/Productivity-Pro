//
//  NoteMainToolToolbarMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.02.23.
//

import SwiftUI

extension NoteMainToolToolbar {
    
    func addShape(type: ShapeType) {
        toolManager.isCanvasEnabled = false
        
        var newItem = ItemModel(
            width: 200,
            height: 200,
            type: .shape
        )
        
        if type == .hexagon {
            newItem.height = 175
        }
        
        newItem.x = toolManager.scrollOffset.size.width * (1/toolManager.zoomScale) + newItem.width/2 + 40
        
        newItem.y = toolManager.scrollOffset.size.height * (1/toolManager.zoomScale) + newItem.height/2 + 40
        
        let shapeModel = ShapeModel(type: type, fillColor: getNIColor())
        newItem.shape = shapeModel
        
        document.document.note.pages[
            toolManager.selectedPage
        ].items.append(newItem)
        toolManager.selectedItem = newItem
        
    }
    
    func addTextField() {
        toolManager.isCanvasEnabled = false
        
        var newItem = ItemModel(
            width: 600,
            height: 300,
            type: .textField
        )
        
        newItem.x = toolManager.scrollOffset.size.width * (1/toolManager.zoomScale) + newItem.width/2 + 40
        
        newItem.y = toolManager.scrollOffset.size.height * (1/toolManager.zoomScale) + newItem.height/2 + 40
        
        let textField = TextFieldModel(
            font: defaultFont,
            fontSize: defaultFontSize,
            fontColor: getNIColor()
        )
        
        newItem.textField = textField
        
        document.document.note.pages[
            toolManager.selectedPage
        ].items.append(newItem)
        toolManager.selectedItem = newItem
    }
    
    func getNIColor() -> Data {
        var color: Color = .black
        let page = document.document.note.pages[
            toolManager.selectedPage
        ]
        
        if page.backgroundColor == "black" || page.backgroundColor == "gray" {
            color = .white
        }
        
        return color.toCodable()
    }
    
}
