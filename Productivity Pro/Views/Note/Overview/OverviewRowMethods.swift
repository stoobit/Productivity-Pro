//
//  OverviewRowMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 02.07.23.
//

import SwiftUI
import PDFKit
import SwiftyMarkdown

extension OverviewRow {
    
    func pageNumber() -> String {
        let index = document.note.pages.firstIndex(of: page) ?? -1
        return "Seite \(index + 1)"
    }
    
    func header() -> String {
        var text: String = ""
        
        if page.type == .pdf {
            
            if let header = page.header {
                text = header
            }
            
        } else {
            let textFields = page.items.filter(
                { $0.type == .textField && $0.isLocked == true }
            )
            
            if let string = textFields.first?.textField?.text {
                text = SwiftyMarkdown(
                    string: string
                ).attributedString().string
            }
            
            text = text.components(separatedBy: .newlines).first ?? ""
            text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        return text
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
