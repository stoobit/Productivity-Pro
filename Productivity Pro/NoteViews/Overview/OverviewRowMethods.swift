//
//  OverviewRowMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 02.07.23.
//

import PDFKit
import SwiftUI

extension OverviewRow {
    func pageNumber() -> LocalizedStringKey {
        return "Seite \(page.index + 1)"
    }
    
    func compactPageNumber() -> LocalizedStringKey {
        return "\(page.index + 1)"
    }

    func openPage() {
        toolManager.activePage = page
        pvModel.index = page.index
        subviewManager.overview.toggle()
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
