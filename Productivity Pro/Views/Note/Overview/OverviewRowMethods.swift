//
//  OverviewRowMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 02.07.23.
//

import SwiftUI

extension OverviewRow {
    
    func openPage() {
        withAnimation {
            toolManager.selectedTab = page.id
            subviewManager.overviewSheet.toggle()
        }
    }
    
    func bookmarkState() -> String {
        var icon: String = "bookmark"
        
        if page.isBookmarked {
            icon = "bookmark.slash"
        }
        
        return icon
    }
    
    func getFrame() -> CGSize {
        var frame: CGSize = .zero
        
        if page.isPortrait {
            frame = CGSize(width: shortSide, height: longSide)
        } else {
            frame = CGSize(width: longSide, height: shortSide)
        }
        
        return frame
    }
    
    func toggleBookmark(page: Page) {
        undoManager?.disableUndoRegistration()
        
        document.document.note.pages[
            document.document.note.pages.firstIndex(of: page)!
        ].isBookmarked.toggle()
        
        undoManager?.enableUndoRegistration()
    }
}
