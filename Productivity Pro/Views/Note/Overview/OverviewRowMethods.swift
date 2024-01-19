//
//  OverviewRowMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 02.07.23.
//

import PDFKit
import SwiftUI

extension OverviewRow {
    func pageNumber() -> String {
//        let index = document.note.pages.firstIndex(of: page) ?? -1
        return "Seite \(2 + 1)"
    }
    
    func header() -> String {
        return page.title
    }

    func openPage() {
        withAnimation {
            toolManager.selectedTab = page.id
        }
        subviewManager.overviewSheet.toggle()
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
}
