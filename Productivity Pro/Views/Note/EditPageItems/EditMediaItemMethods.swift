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
    
    
    func onEditModelChange() {
        if let index = itemIndex {
            
            document.note.pages[
                toolManager.selectedPage
            ].items[index].media?.showStroke = editMediaModel.showStroke
            
            document.note.pages[
                toolManager.selectedPage
            ].items[index].media?.strokeColor = editMediaModel.strokeColor.toCodable()
            
            document.note.pages[
                toolManager.selectedPage
            ].items[index].media?.strokeWidth = editMediaModel.strokeWidth
            
            document.note.pages[
                toolManager.selectedPage
            ].items[index].media?.cornerRadius = editMediaModel.cornerRadius
            
            document.note.pages[
                toolManager.selectedPage
            ].items[index].rotation = editMediaModel.rotation
            
            toolManager.selectedItem = document.note.pages[
                toolManager.selectedPage
            ].items[index]
        }
    }
    
    func onAppear() {
        
        let selectedItem = document.note.pages[
            toolManager.selectedPage
        ].items.first(where: { $0.id == toolManager.selectedItem?.id })
        
        if let item = selectedItem {
            if let media = item.media {
                editMediaModel = EditMediaModel(
                    rotation: item.rotation,
                    showStroke: media.showStroke,
                    strokeColor: Color(codable: media.strokeColor),
                    strokeWidth: media.strokeWidth,
                    cornerRadius: media.cornerRadius
                )
            }
        }
    }
    
}
