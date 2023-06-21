//
//  OverviewMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 04.06.23.
//

import SwiftUI

extension OverviewView {
    
    func delete(_ page: Page) {
        toolManager.selectedItem = nil
        document.document.note.pages[
            toolManager.selectedPage
        ].items = []
        
        let pages = document.document.note.pages
        
        if page == document.document.note.pages.last! {
            
            if toolManager.selectedTab == page.id {
                if page.id == pages.first?.id {
                    toolManager.selectedPage = document.document.note.pages.firstIndex(
                        of: page
                    )! + 1
                } else {
                    toolManager.selectedPage = document.document.note.pages.firstIndex(
                        of: page
                    )! - 1
                }
            }
            
            document.document.note.pages.removeAll(where: {
                $0.id == page.id
            })
            
        } else {
            let pageIndex: Int = document.document.note.pages.firstIndex(of: page)!
            
            if pageIndex < toolManager.selectedPage {
                
                let selection = document.document.note.pages[
                    toolManager.selectedPage
                ].id
                
                document.document.note.pages.removeAll(where: {
                    $0 == page
                })
                
                toolManager.selectedTab = selection
                toolManager.selectedPage = document.document.note.pages.firstIndex(
                    where: { $0.id == selection }) ?? 0
                
            } else if pageIndex == toolManager.selectedPage {
                toolManager.selectedTab = document.document.note.pages[
                    toolManager.selectedPage + 1
                ].id
                
                document.document.note.pages.removeAll(where: { $0 == page })
                
            } else if pageIndex > toolManager.selectedPage {
                document.document.note.pages.removeAll(where: { $0 == page })
            }
            
        }
    }
    
    func goToPage(page: Page) {
        withAnimation {
            toolManager.selectedTab = page.id
            subviewManager.overviewSheet.toggle()
        }
    }
    
    func toggleBookmark(page: Page) {
        undoManager?.disableUndoRegistration()
        
        document.document.note.pages[
            document.document.note.pages.firstIndex(of: page)!
        ].isBookmarked.toggle()
        
        undoManager?.enableUndoRegistration()
    }
    
}
