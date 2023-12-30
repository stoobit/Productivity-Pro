//
//  ClipboardMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 22.12.23.
//

import SwiftUI

extension ClipboardControl {
    func delete() {
        toolManager.activePage?.deleteItem(
            with: toolManager.activeItem?.id
        )
        
        toolManager.activeItem = nil
    }
    
    func duplicate() {
        
    }
    
    func copy() {
//        let jsonData = try? JSONEncoder().encode(toolManager.activeItem)
//        if let data = jsonData {
//            UIPasteboard.general.setData(
//                data, forPasteboardType: "productivity pro"
//            )
//        }
    }
    
    func paste() {}
    
    func cut() {}
}
