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
        guard let original = toolManager.activeItem else { return }
        let duplicate = original as! NSObject
        let item = duplicate.copy() as! PPItemModel
        
        item.x += 50
        item.y += 50
        
        toolManager.activeItem = item
    }
    
}
