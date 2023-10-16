//
//  EditTextfieldItemViewMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 15.06.23.
//

import SwiftUI

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
    
    var isLocked: Bool = false
    
}

extension EditTextfieldItemView {
    
    func center() {
        
        let itemIndex = document.note.pages[
            toolManager.selectedPage
        ].items.firstIndex(
            where: { $0.id == toolManager.selectedItem?.id }
        )
        
        if let index = itemIndex {
            document.note.pages[
                toolManager.selectedPage
            ].items[index].width = getFrame().width - 100
            document.note.pages[
                toolManager.selectedPage
            ].items[index].height = getFrame().height - 100
            
            document.note.pages[
                toolManager.selectedPage
            ].items[index].x = getFrame().width / 2
            
            document.note.pages[
                toolManager.selectedPage
            ].items[index].y = getFrame().height / 2
        }
        
        if let id = toolManager.selectedItem?.id {
            
            toolManager.selectedItem = nil
            toolManager.selectedItem = document.note.pages[
                toolManager.selectedPage
            ].items.first(where: { $0.id == id })
        }
        
    }
    
    func disableLock() -> Bool {
        var isLockDisabled: Bool = true
        let item: ItemModel = toolManager.selectedItem!
        
        if item.x == getFrame().width / 2 &&
            item.y == getFrame().height / 2 &&
            item.width == getFrame().width - 100 &&
            item.height == getFrame().height - 100
        {
            isLockDisabled = false
        }
        
        return isLockDisabled
    }
    
    func getFrame() -> CGSize {
        let page = document.note.pages[toolManager.selectedPage]
        
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
        
        let index = document.note.pages[
            toolManager.selectedPage
        ].items.firstIndex(
            where: { $0.id == toolManager.selectedItem?.id }
        )!
        
        if index + 1 != document.note.pages[
            toolManager.selectedPage
        ].items.count {
            document.note.pages[
                toolManager.selectedPage
            ].items.move(toolManager.selectedItem!, to: index + 1)
        }
    }
    
    func moveDown() {
        
        let index = document.note.pages[
            toolManager.selectedPage
        ].items.firstIndex(
            where: { $0.id == toolManager.selectedItem?.id }
        )!
        
        if index != 0 {
            document.note.pages[
                toolManager.selectedPage
            ].items.move(toolManager.selectedItem!, to: index - 1)
        }
    }
    
    func moveHighest() {
        
        let lastIndex = document.note.pages[
            toolManager.selectedPage
        ].items.firstIndex(
            where: { $0.id == document.note.pages[
                toolManager.selectedPage
            ].items.last!.id }
        )!
        
        document.note.pages[
            toolManager.selectedPage
        ].items.move(toolManager.selectedItem!, to: lastIndex)
    }
    
    func moveLowest() {
        
        let firstIndex = document.note.pages[
            toolManager.selectedPage
        ].items.firstIndex(
            where: { $0.id == document.note.pages[
                toolManager.selectedPage
            ].items.first!.id }
        )!
        
        document.note.pages[
            toolManager.selectedPage
        ].items.move(toolManager.selectedItem!, to: firstIndex)
    }
    
    func onAppear() {
        let selectedItem = document.note.pages[
            toolManager.selectedPage
        ].items.first(where: { $0.id == toolManager.selectedItem?.id })
        
        if let item = selectedItem {
            if let textField = item.textField {
                editTextFieldModel = EditTextFieldModel(
                    text: textField.text,
                    showFill: textField.showFill,
                    fillColor: Color(codable: textField.fillColor),
                    showStroke: textField.showStroke,
                    strokeColor: Color(codable: textField.strokeColor),
                    strokeWidth: textField.strokeWidth,
                    font: textField.font,
                    fontColor: Color(codable: textField.fontColor),
                    fontSize: textField.fontSize,
                    isLocked: item.isLocked ?? false
                )
            }
        }
    }
    
    func onEditModelChange() {
        if let index = itemIndex {
            
            document.note.pages[
                toolManager.selectedPage
            ].items[index].textField?.showFill = editTextFieldModel.showFill
            
            document.note.pages[
                toolManager.selectedPage
            ].items[index].textField?.fillColor = editTextFieldModel.fillColor.toCodable()
            
            document.note.pages[
                toolManager.selectedPage
            ].items[index].textField?.showStroke = editTextFieldModel.showStroke
            
            document.note.pages[
                toolManager.selectedPage
            ].items[index].textField?.strokeColor = editTextFieldModel.strokeColor.toCodable()
            
            document.note.pages[
                toolManager.selectedPage
            ].items[index].textField?.strokeWidth = editTextFieldModel.strokeWidth
            
            document.note.pages[
                toolManager.selectedPage
            ].items[index].textField?.font = editTextFieldModel.font
            
            document.note.pages[
                toolManager.selectedPage
            ].items[index].textField?.fontSize = editTextFieldModel.fontSize
            
            document.note.pages[
                toolManager.selectedPage
            ].items[index].textField?.fontColor = editTextFieldModel.fontColor.toCodable()
            
            document.note.pages[
                toolManager.selectedPage
            ].items[index].isLocked = editTextFieldModel.isLocked
            
            toolManager.selectedItem = document.note.pages[
                toolManager.selectedPage
            ].items[index]
            
        }
    }
    
}
