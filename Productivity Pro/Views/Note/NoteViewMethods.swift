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
    
    func resetControls() {
        toolManager.selectedItem = nil
        toolManager.isCanvasEnabled = false
        toolManager.isLocked = false
        toolManager.firstZoom = true
        toolManager.zoomScale = 1
        toolManager.scrollOffset = .zero
        toolManager.selectedPage = 0
        toolManager.selectedTab = UUID()
        toolManager.showProgress = false
        toolManager.animatedZoom = true
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
    
    func removePage() {
        toolManager.selectedItem = nil
        
        let page = document.document.note.pages.first(where: {
            $0.id == toolManager.selectedTab
        })
        
        if page == document.document.note.pages.last! {
            
            toolManager.selectedPage = document.document.note.pages.firstIndex(
                of: document.document.note.pages.last!
            )! - 1
        
            Task {
                try? await Task.sleep(nanoseconds: 500000)
                document.document.note.pages.removeAll(where: {
                    $0.id == document.document.note.pages.last!.id
                })
            }
            
        } else {
            
            toolManager.selectedTab = document.document.note.pages[
                toolManager.selectedPage + 1
            ].id
            
            let new = toolManager.selectedTab
            
            toolManager.selectedPage = document.document.note.pages.firstIndex(
                where: { $0.id == toolManager.selectedTab }
            ) ?? 0
            
            Task {
                try? await Task.sleep(nanoseconds: 500000)
                document.document.note.pages.remove(at: toolManager.selectedPage - 1)
                toolManager.selectedTab = new
                if let page = document.document.note.pages.firstIndex(where: {
                    $0.id == toolManager.selectedTab
                }) {
                    toolManager.selectedPage = page
                }
            }
            
        }
        
        undoManager?.removeAllActions() 
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
    
}
