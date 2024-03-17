//
//  ClipboardMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 22.12.23.
//

import SwiftUI

extension ClipboardControl {
    func delete() {
        toolManager.activePage?.deleteItem(
            with: toolManager.activeItem?.id
        )
        
        toolManager.activePage?.store(toolManager.activeItem!, type: .delete) {
            toolManager.activeItem!
        }
        
        toolManager.activeItem = nil
    }
    
    func duplicate() {
        guard let item = toolManager.activeItem else { return }
        var exportable = ExportManager().export(item: item)
        
        exportable.id = UUID()
        exportable.index = toolManager.activePage?.items?.count ?? 0
        
        exportable.x += 50
        exportable.y += 50
        
        let duplicate = ImportManager().ppImport(item: exportable)
        toolManager.activePage?.items?.append(duplicate)
        
        toolManager.activePage?.store(duplicate, type: .create) {
            duplicate
        }
        
        toolManager.activeItem = duplicate
    }
    
    func copy() {
        guard let item = toolManager.activeItem else { return }
        
        let exportable = ExportManager().export(item: item)
        let jsonData = try? JSONEncoder().encode(exportable)
        
        if let data = jsonData {
            UIPasteboard.general.setData(
                data, forPasteboardType: "productivityproitem"
            )
        }
    }
    
    func paste() {
        if UIPasteboard.general.hasImages {
            addImage()
        } else if UIPasteboard.general.hasStrings {
            addTextField()
        } else if UIPasteboard.general.contains(pasteboardTypes: ["productivityproitem"]) {
            addItem()
        } else {
            alert.toggle()
        }
    }
    
    func addImage() {
        guard let selectedImage = UIPasteboard.general.image else { return }
        
        let image = resize(selectedImage, to: CGSize(width: 2048, height: 2048))
        let ratio = 400/image.size.width
        
        let item = PPItemModel(index: 0, type: .media)
        item.width = image.size.width * ratio
        item.height = image.size.height * ratio
        
        let size = toolManager.offset.size
        let scale = (1/toolManager.scale)
        
        item.x = size.width * scale + item.width/2 + 40
        item.y = size.height * scale + item.height/2 + 40
        
        guard let data = image.heicData() else { return }
        let media = PPMediaModel(media: data)
        
        item.media = media
        
        let page = toolManager.activePage
        item.index = page?.items?.count ?? 0
        page?.items?.append(item)
        
        page?.store(item, type: .create) {
            item
        }
        
        toolManager.activeItem = item
    }
    
    func addTextField() {
        if let string = UIPasteboard.general.string {
            let item = PPItemModel(index: 0, type: .textField)
            item.width = 600
            item.height = 300
            
            let size = toolManager.offset.size
            let scale = (1/toolManager.scale)
            
            item.x = size.width * scale + item.width/2 + 40
            item.y = size.height * scale + item.height/2 + 40
            
            let textField = PPTextFieldModel(
                textColor: primaryColor(),
                font: defaultFont,
                fontSize: defaultFontSize
            )
            
            item.textField = textField
            textField.string = string
            
            let page = toolManager.activePage
            item.index = page?.items?.count ?? 0
            page?.items?.append(item)
            
            page?.store(item, type: .create) {
                item
            }
            
            toolManager.activeItem = item
        }
    }
    
    func addItem() {
        do {
            let jsonData = UIPasteboard.general
                .data(forPasteboardType: "productivityproitem")
            
            if let data = jsonData {
                var pasteItem: ExportableItemModel = try JSONDecoder().decode(
                    ExportableItemModel.self, from: data
                )
                
                let size = toolManager.offset.size
                let scale = (1/toolManager.scale)
                
                pasteItem.id = UUID()
                pasteItem.index = toolManager.activePage?.items?.count ?? 0
                pasteItem.x = size.width * scale + pasteItem.width/2 + 40
                pasteItem.y = size.height * scale + pasteItem.height/2 + 40
                
                let item = ImportManager().ppImport(item: pasteItem)
                toolManager.activePage?.items?.append(item)
                
                toolManager.activePage?.store(item, type: .create) {
                    item
                }
                
                toolManager.activeItem = item
            }
            
        } catch {}
    }
    
    func cut() {
        copy()
        delete()
    }
    
    func primaryColor() -> Color {
        let page = toolManager.activePage
        
        if page?.color == "pageblack" || page?.color == "pagegray" {
            return Color.white
        } else {
            return Color.black
        }
    }
}
