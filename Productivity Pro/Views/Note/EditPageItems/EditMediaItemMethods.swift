//
//  EditMediaItemMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 15.06.23.
//

import SwiftUI

struct EditMediaModel: Equatable {
    var rotation: Double = 0
    
    var showStroke: Bool = false
    var strokeColor: Color = .accentColor
    
    var strokeWidth: Double = 5
    var cornerRadius: Double = 10
}


extension EditMediaItemView {
    
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
    
    
    func onEditModelChange() {
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
    
    func onAppear() {
        
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
