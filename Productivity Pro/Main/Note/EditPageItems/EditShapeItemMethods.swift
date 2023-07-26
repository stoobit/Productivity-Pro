//
//  EditShapeItemViewMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 14.06.23.
//

import SwiftUI

struct EditShapeModel: Equatable {
    var rotation: Double = 0
    
    var showFill: Bool = true
    var fillColor: Color = .primary
    
    var showStroke: Bool = false
    var strokeColor: Color = .accentColor
    
    var strokeWidth: Double = 5
    
    var cornerRadius: Double = 10
}


extension EditShapeItemView {
    
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
    
    func onAppear() {
        
        let selectedItem = document.document.note.pages[
            toolManager.selectedPage
        ].items.first(where: { $0.id == toolManager.selectedItem?.id })
        
        if let item = selectedItem {
            if let shape = item.shape {
                editShapeModel = EditShapeModel(
                    rotation: item.rotation,
                    showFill: shape.showFill,
                    fillColor: Color(codable: shape.fillColor)!,
                    showStroke: shape.showStroke,
                    strokeColor: Color(codable: shape.strokeColor)!,
                    strokeWidth: shape.strokeWidth,
                    cornerRadius: shape.cornerRadius
                )
            }
        }
        
    }
    
    func onEditModelChange(itemIndex: Int?) {
        if let index = itemIndex {
            
            document.document.note.pages[
                toolManager.selectedPage
            ].items[index].shape?.showFill = editShapeModel.showFill
            
            document.document.note.pages[
                toolManager.selectedPage
            ].items[index].shape?.fillColor = editShapeModel.fillColor.toCodable()
            
            document.document.note.pages[
                toolManager.selectedPage
            ].items[index].shape?.showStroke = editShapeModel.showStroke
            
            document.document.note.pages[
                toolManager.selectedPage
            ].items[index].shape?.strokeColor = editShapeModel.strokeColor.toCodable()
            
            document.document.note.pages[
                toolManager.selectedPage
            ].items[index].shape?.strokeWidth = editShapeModel.strokeWidth
            
            document.document.note.pages[
                toolManager.selectedPage
            ].items[index].shape?.cornerRadius = editShapeModel.cornerRadius
            
            document.document.note.pages[
                toolManager.selectedPage
            ].items[index].rotation = editShapeModel.rotation
            
            toolManager.selectedItem = document.document.note.pages[
                toolManager.selectedPage
            ].items[index]
        }
    }
    
}
