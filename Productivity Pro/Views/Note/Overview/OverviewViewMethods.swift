//
//  OverviewMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 04.06.23.
//

import SwiftUI

extension OverviewView {
    
    func move(from source: IndexSet, to destination: Int) {
        document.note.pages.move(
            fromOffsets: source, toOffset: destination
        )
        
        toolManager.preloadedMedia.move(
            fromOffsets: source, toOffset: destination
        )
        
        toolManager.selectedPage = document.note.pages.firstIndex(
            where: { $0.id == toolManager.selectedTab }
        )!
    }
    
    func delete(at offsets: IndexSet) {
        withAnimation {
            
            document.note.pages[offsets.first!].items.removeAll()
            document.note.pages[offsets.first!].type = .template
            
            let page = document.note.pages[offsets.first!]
            toolManager.preloadedMedia.remove(at: offsets.first!)
            
            let seconds = 0.1
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                if page.id == document.note.pages.last?.id {
                    
                    var newSelection: UUID = UUID()
                    
                    if toolManager.selectedTab == page.id {
                        newSelection = document.note.pages[offsets.first! - 1].id
                    } else {
                        newSelection = toolManager.selectedTab
                    }
                    
                    document.note.pages.remove(at: offsets.first!)
                    toolManager.selectedTab = newSelection
                    
                } else {
                    
                    var newSelection: UUID = UUID()
                    let index = document.note.pages.firstIndex(of: page)!
                    
                    if index < toolManager.selectedPage {
                        
                        newSelection = toolManager.selectedTab
                        
                    } else if index > toolManager.selectedPage {
                        
                        newSelection = toolManager.selectedTab
                        
                    } else if index == toolManager.selectedPage {
                        
                        newSelection = document.note.pages[offsets.first! + 1].id
                        
                    }
                    
                    document.note.pages.remove(at: offsets.first!)
                    
                    toolManager.selectedPage = document.note.pages.firstIndex(where: {
                        $0.id == newSelection
                    }) ?? toolManager.selectedPage
                    toolManager.selectedTab = newSelection
                    
                }
                
                undoManager?.removeAllActions()
                toolManager.selectedItem = nil
            }
        }
    }
    
}
