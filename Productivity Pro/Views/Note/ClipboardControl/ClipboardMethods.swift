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
        }
    }
    
    func addImage() {
        toolManager.showProgress = true
        Task {
            await MainActor.run {
                addImage()
                
                toolManager.showProgress = false
                toolManager.copyPastePasser = .none
            }
        }
    }
    
    func addTextField() {}
    
    func addItem() {
        Task {
            await MainActor.run {
                do {
                    let jsonData = UIPasteboard.general
                        .data(forPasteboardType: "productivityproitem")
                    
                    if let data = jsonData {
                        var pasteItem: ItemModel = try JSONDecoder().decode(
                            ItemModel.self, from: data
                        )
                        
                        toolManager.showProgress = true
                        
                        pasteItem.id = UUID()
                        
                        pasteItem.x = toolManager.offset.size.width * (1/toolManager.scale) + pasteItem.width/2 + 40
                        
                        pasteItem.y = toolManager.scrollOffset.size.height * (1/toolManager.zoomScale) + pasteItem.height/2 + 40
                        
                        pasteItem.isLocked = false
                        
                        document.document.note.pages[
                            toolManager.selectedPage
                        ].items.append(pasteItem)
                        
                        toolManager.selectedItem = pasteItem
                    }
                    
                } catch { print("fail") }
                
                toolManager.showProgress = false
                toolManager.copyPastePasser = .none
            }
        }
    }
    
    func cut() {
        copy()
        delete()
    }
}
