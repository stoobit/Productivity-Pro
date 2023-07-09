//
//  OverviewMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 04.06.23.
//

import SwiftUI

extension OverviewView {
    
    func move(from source: IndexSet, to destination: Int) {
        document.document.note.pages.move(fromOffsets: source, toOffset: destination)
        toolManager.selectedPage = document.document.note.pages.firstIndex(where: {
            $0.id == toolManager.selectedTab
        })!
    }
    
    func delete(at offsets: IndexSet) {
        document.document.note.pages[offsets.first!].items = []
        document.document.note.pages[offsets.first!].type = .template
        
        let page = document.document.note.pages[offsets.first!]
        
        if page.id == document.document.note.pages.last?.id {
            
            var newSelection: UUID = UUID()
            
            if toolManager.selectedTab == page.id {
                newSelection = document.document.note.pages[offsets.first! - 1].id
            } else {
                newSelection = toolManager.selectedTab
            }
            
            document.document.note.pages.remove(at: offsets.first!)
            toolManager.selectedTab = newSelection
            
        } else {
            
            var newSelection: UUID = UUID()
            let index = document.document.note.pages.firstIndex(of: page)!
            
            if index < toolManager.selectedPage {
                
                newSelection = toolManager.selectedTab
                
            } else if index < toolManager.selectedPage {
                
                newSelection = toolManager.selectedTab
                
            } else if index == toolManager.selectedPage {
                
                newSelection = document.document.note.pages[offsets.first! + 1].id
                
            }
            
            document.document.note.pages.remove(at: offsets.first!)
            toolManager.selectedTab = newSelection
            
        }
        
        undoManager?.removeAllActions()
        toolManager.selectedItem = nil
    }
    
    func delete(_ page: Page) {
        toolManager.selectedItem = nil
        document.document.note.pages[
            document.document.note.pages.firstIndex(of: page)!
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
            guard let pageIndex: Int = document.document.note.pages
                .firstIndex(of: page) else { return }
            
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
    
}
