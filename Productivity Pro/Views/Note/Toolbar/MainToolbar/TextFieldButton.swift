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
        toolManager.isCanvasEnabled = false
        
        let item = PPItemModel(type: .textField)
        item.size = PPSize(width: 600, height: 300)
        
        item.position.x = toolManager.scrollOffset.size.width * (1/toolManager.zoomScale) + item.size.width/2 + 40
        
        item.position.y = toolManager.scrollOffset.size.height * (1/toolManager.zoomScale) + item.size.height/2 + 40
        
        let textField = PPTextFieldModel()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(primaryColor()),
            .font: UIFont(name: defaultFont, size: defaultFontSize)!
        ]
        
        let string = NSAttributedString(
            string: "", attributes: attributes
        )
        
        textField.nsAttributedString = string.toCodable()
        item.textField = textField
        
        if let page = contentObject.note!.pages!.first(where: {
            $0.id == toolManager.activePage.id
        }) {
            page.items.append(item)
        }
    }
    
}
