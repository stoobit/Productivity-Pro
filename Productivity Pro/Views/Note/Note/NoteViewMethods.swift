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
    
    func pickedImageDidChange() {
        if let image = toolManager.pickedImage { addImage(image) }
        toolManager.pickedImage = nil
    }
    
    func noteDidAppear() {
        UITabBar.appearance().isHidden = true
        checkLockStatus()
        
        toolManager.selectedTab = document.document.note.pages.last!.id
        
        toolManager.selectedPage = document.document.note.pages.firstIndex(
            where: { $0.id == toolManager.selectedTab }
        )!
        
        fixScrollViewBug()
    }
    
    func selectedPageDidChange(index page: Int) {
        toolManager.selectedTab = document.document.note.pages[
            page
        ].id
    }
    
    func selectedTabDidChange(_ tab: UUID, size: CGSize) {
        toolManager.selectedPage = document.document.note.pages.firstIndex(where: {
            $0.id == tab
        }) ?? 0
        
        toolManager.selectedItem = nil
        toolManager.scrollOffset = .zero
        toolManager.zoomScale = getScale(
            toolManager.selectedPage, size: size
        )
        
        pageIndicator()
    }
    
    func checkLockStatus() {
        let dateTrialEnd = Calendar.current.date(
            byAdding: .day,
            value: freeTrialDays,
            to: Date(rawValue: startDate)!
        )
        
        if !isFullAppUnlocked && dateTrialEnd! < Date() {
            subviewManager.isPresentationMode = true
        }
    }
    
    func fixScrollViewBug() {
        Task {
            document.document.note.pages.append(Page(backgroundColor: "white", backgroundTemplate: "blank", isPortrait: true))
            try? await Task.sleep(nanoseconds: 50000)
            document.document.note.pages.removeLast()
            try? await Task.sleep(nanoseconds: 50000)
            undoManager?.removeAllActions()
        }
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
        
        let media = MediaModel(media: image.pngData() ?? Data())
        newItem.media = media
        
        document.document.note.pages[
            toolManager.selectedPage
        ].items.append(newItem)
        
        toolManager.selectedItem = newItem
        toolManager.showProgress = false
    }
    
    func deletePage() {
        toolManager.selectedItem = nil
        
        document.document.note.pages[
            toolManager.selectedPage
        ].items = []
        
        withAnimation {
            if toolManager.selectedTab == document.document.note.pages.last!.id {
                
                removePage(next: -1)
            } else {
                removePage(next: 1)
            }
        }
        
        undoManager?.removeAllActions() 
    }
    
    func removePage(next: Int) {
        toolManager.selectedTab = document.document.note.pages[
            document.document.note.pages.firstIndex(where: {
                $0.id == toolManager.selectedTab
            })! + next
        ].id
        
        toolManager.selectedPage = document.document.note.pages.firstIndex(where: {
            $0.id == toolManager.selectedTab
        })!
        
        let toRemove = document.document.note.pages[
            document.document.note.pages.firstIndex(where: {
                $0.id == toolManager.selectedTab
            })! - next
        ].id
        
        document.document.note.pages.removeAll(where: {
            $0.id == toRemove
        })
        
        toolManager.selectedPage = document.document.note.pages.firstIndex(where: {
            $0.id == toolManager.selectedTab
        })!
    }
    
    func pageIndicator() {
        toolManager.isPageNumberVisible = true
        Task {
            try? await Task.sleep(nanoseconds: 3_000_000_000)
            withAnimation {
                toolManager.isPageNumberVisible = false
            }
        }
    }
    
    func colorScheme(page: Page) -> ColorScheme {
        var cs: ColorScheme = .dark
        
        if page.backgroundColor == "yellow" || page.backgroundColor == "white" {
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
        
        let page = document.document.note.pages[index]
        
        if page.isPortrait {
            scale = size.width / shortSide
        } else {
            scale = size.width / longSide
        }
        
        return scale
    }
    
}
