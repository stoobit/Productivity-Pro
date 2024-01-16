//
//  TextFieldButton.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.10.23.
//

import SwiftUI

extension NoteMainToolbar {
    @ViewBuilder func TextFieldButton() -> some View {
        Button(action: { addTextField() }) {
            Label("Text", systemImage: "character.textbox")
        }
    }
    
    func addTextField() {
        toolManager.pencilKit = false
        
        let item = PPItemModel(index: 0, type: .textField)
        item.width = 600
        item.height = 300
        
        item.x = toolManager.offset.size.width * (1/toolManager.scale) + item.width/2 + 40
        
        item.y = toolManager.offset.size.height * (1/toolManager.scale) + item.height/2 + 40
        
        let textField = PPTextFieldModel(
            textColor: primaryColor(),
            font: defaultFont,
            fontSize: defaultFontSize
        )
      
        item.textField = textField
        
        if let page = contentObject.note?.pages?.first(where: {
            $0.id == toolManager.activePage?.id
        }) {
            item.index = page.items?.count ?? 0
            page.items?.append(item)
            
            toolManager.activeItem = item
        }
    }
}
