//
//  NoteViewMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 23.03.23.
//

import SwiftUI
import PencilKit
import PDFKit

extension NoteView {
    
    func isViewVisible(page: Page) -> Bool {
        var isVisible: Bool = false
        
        let index = document.note.pages.firstIndex(of: page)!
        
        if toolManager.selectedPage == index {
            isVisible = true
        } else if toolManager.selectedPage - 1 == index {
            isVisible = true
        } else if toolManager.selectedPage + 1 == index {
            isVisible = true
        }
        
        return isVisible
    }
    
    func pickedImageDidChange() {
        if let image = toolManager.pickedImage { addImage(image) }
        toolManager.pickedImage = nil
    }
    
    func selectedTabDidChange(_ tab: UUID, size: CGSize) {
        toolManager.selectedPage = document.note.pages.firstIndex(where: {
            $0.id == tab
        }) ?? 0
        
        toolManager.selectedItem = nil
        toolManager.scrollOffset = .zero
        toolManager.zoomScale = getScale(
            toolManager.selectedPage, size: size
        )
        
        pageIndicator()
    }
    
    func addImage(_ img: UIImage) {
        let image = resize(img, to: CGSize(width: 1024, height: 1024))
        
        let ratio = 400/image.size.width
        
        var newItem = ItemModel(
            width: image.size.width * ratio,
            height: image.size.height * ratio,
            type: .media
        )
        
        newItem.x = toolManager.scrollOffset.size.width * (1/toolManager.zoomScale) + newItem.width/2 + 40
        
        newItem.y = toolManager.scrollOffset.size.height * (1/toolManager.zoomScale) + newItem.height/2 + 40
        
        let media = MediaModel(media: image.heicData() ?? Data())
        newItem.media = media
        
        document.note.pages[
            toolManager.selectedPage
        ].items.append(newItem)
        
        toolManager.selectedItem = newItem
        toolManager.showProgress = false
    }
    
    func pageIndicator() {
        if subviewManager.overviewSheet == false {
            toolManager.isPageNumberVisible = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    toolManager.isPageNumberVisible = false
                }
            }
        }
    }
    
    func colorScheme(page: Page) -> ColorScheme {
        var cs: ColorScheme = .dark
        
        if  page.backgroundColor == "pagewhite" ||  page.backgroundColor == "white" ||  page.backgroundColor == "pageyellow" ||  page.backgroundColor == "yellow"{
            cs = .light
        }
        
        return cs
    }
    
    func getFrame(for page: Page) -> CGSize {
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
    
    func getScale(_ index: Int, size: CGSize) -> CGFloat {
        var scale: CGFloat = 0
        
        let page = document.note.pages[index]
        
        if page.isPortrait {
            scale = size.width / shortSide
        } else {
            scale = size.width / longSide
        }
        
        return scale
    }
    
}
