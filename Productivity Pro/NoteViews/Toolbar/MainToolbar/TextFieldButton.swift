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
        
        let size = Pos.calculate(model: toolManager, item: item, size: size)
        item.x = size.x
        item.y = size.y
        
        let textField = PPTextFieldModel(
            textColor: primaryColor(),
            font: defaultFont,
            fontSize: defaultFontSize
        )
      
        item.textField = textField
        let page = toolManager.activePage
        item.index = page?.items?.count ?? 0
        page?.items?.append(item)
        
        page?.store(item, type: .create) {
            item
        }
        
        toolManager.activeItem = item
    }
}
