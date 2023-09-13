//
//  PPControlBarMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.07.23.
//

import SwiftUI

extension PPControlBar {
    
    func copyItem() {
        toolManager.selectedItem = document.note.pages[
            toolManager.selectedPage
        ].items.first(where: { $0.id == toolManager.selectedItem?.id })
        
        let jsonData = try? JSONEncoder().encode(toolManager.selectedItem!)
        if let data = jsonData {
            UIPasteboard.general.setData(
                data, forPasteboardType: "productivity pro"
            )
        }
    }
    
    func pasteItem() {
        
        if UIPasteboard.general.hasImages {
            toolManager.showProgress = true
            Task {
                await MainActor.run {
                    addImage()
                    
                    toolManager.showProgress = false
                    toolManager.copyPastePasser = .none
                }
            }
        } else if UIPasteboard.general.hasStrings {
            addTextField()
        } else if UIPasteboard.general.contains(pasteboardTypes: ["productivity pro"]){
            
            Task {
                await MainActor.run {
                    do {
                        let jsonData = UIPasteboard.general.data(
                            forPasteboardType: "productivity pro"
                        )
                        
                        if let data = jsonData {
                            var pasteItem: ItemModel = try JSONDecoder().decode(
                                ItemModel.self, from: data
                            )
                            
                            toolManager.showProgress = true
                            
                            pasteItem.id = UUID()
                            
                            pasteItem.x = toolManager.scrollOffset.size.width * (1/toolManager.zoomScale) + pasteItem.width/2 + 40
                            
                            pasteItem.y = toolManager.scrollOffset.size.height * (1/toolManager.zoomScale) + pasteItem.height/2 + 40
                            
                            pasteItem.isLocked = false
                            
                            document.note.pages[
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
    }
    
    func duplicateItem() {
        toolManager.copyPastePasser = .none
        
        toolManager.selectedItem = document.note.pages[
            toolManager.selectedPage
        ].items.first(where: { $0.id == toolManager.selectedItem?.id })
        
        if let item = toolManager.selectedItem {
            var newItem = item
            
            newItem.id = UUID()
            newItem.x += 50
            newItem.y += 50
            
            newItem.isLocked = false
            
            document.note.pages[
                toolManager.selectedPage
            ].items.append(newItem)
            
            toolManager.selectedItem = newItem
            
        }
    }
    
    func cutItem() {
        copyItem()
        deleteItem()
        
        toolManager.copyPastePasser = .none
    }
    
    func deleteItem() {
        
        let index = document.note.pages[
            toolManager.selectedPage
        ].items.firstIndex(where: {
            $0.id == toolManager.selectedItem?.id
        })!
        
        document.note.pages[
            toolManager.selectedPage
        ].items.remove(at: index)
    
        toolManager.copyPastePasser = .none
        toolManager.selectedItem = nil
    }
    
    func disablePasteboard() {
        if UIPasteboard.general.hasStrings {
            pasteDisabled = false
        } else if UIPasteboard.general.hasImages {
            pasteDisabled = false
        } else {
            pasteDisabled = !UIPasteboard.general.types.contains(
                "productivity pro"
            )
        }
    }
    
    func addTextField() {
        if let string = UIPasteboard.general.string {
            var newItem = ItemModel(
                width: 600,
                height: 300,
                type: .textField
            )
            
            newItem.x = toolManager.scrollOffset.size.width * (1/toolManager.zoomScale) + newItem.width/2 + 40
            
            newItem.y = toolManager.scrollOffset.size.height * (1/toolManager.zoomScale) + newItem.height/2 + 40
            
            let textField = TextFieldModel(
                text: string,
                font: defaultFont,
                fontSize: defaultFontSize,
                fontColor: getNIColor()
            )
            
            newItem.textField = textField
            
            document.note.pages[
                toolManager.selectedPage
            ].items.append(newItem)
            toolManager.selectedItem = newItem
        }
    }
    
    func addImage() {
        
        let img = UIPasteboard.general.image ?? UIImage()
        let image = resize(img, to: CGSize(width: 1024, height: 1024))
        let ratio = 400/image.size.width
        
        var newItem = ItemModel(
            width: image.size.width * ratio,
            height: image.size.height * ratio,
            type: .media
        )
        
        newItem.x = toolManager.scrollOffset.size.width * (1/toolManager.zoomScale) + newItem.width/2 + 40
        
        newItem.y = toolManager.scrollOffset.size.height * (1/toolManager.zoomScale) + newItem.height/2 + 40
        
        let media = MediaModel(media: image.pngData() ?? Data())
        newItem.media = media
        
        document.note.pages[
            toolManager.selectedPage
        ].items.append(newItem)
        toolManager.selectedItem = newItem
    }
    
    func getNIColor() -> Data {
        var color: Color = .black
        let page = document.note.pages[
            toolManager.selectedPage
        ]
        
        if page.backgroundColor == "pageblack" || page.backgroundColor == "pagegray" {
            color = .white
        }
        
        return color.toCodable()
    }
    
}
