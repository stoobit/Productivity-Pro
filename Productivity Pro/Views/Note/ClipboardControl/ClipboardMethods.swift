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
        guard let item = toolManager.activeItem else { return }
        var exportable = ExportManager().export(item: item)
        
        exportable.id = UUID()
        exportable.index = toolManager.activePage?.items?.count ?? 0
        
        exportable.x += 50
        exportable.y += 50
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
