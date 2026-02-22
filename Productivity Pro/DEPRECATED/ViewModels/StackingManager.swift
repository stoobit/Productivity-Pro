//
//  StackingManager.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.12.23.
//

import SwiftUI

struct StackingManager {
    var items: [PPItemModel]
    
    func moveUp(item: PPItemModel) {
        if item.index < (items.count - 1) {
            let changable = items.first(where: {
                $0.index == (item.index + 1)
            })
            
            changable?.index -= 1
            item.index += 1
        }
    }
    
    func moveDown(item: PPItemModel) {
        if item.index > 0 {
            let changable = items.first(where: {
                $0.index == (item.index - 1)
            })
            
            changable?.index += 1
            item.index -= 1
        }
    }
    
    func bringFront(item: PPItemModel) {
        for changable in items {
            if changable.index > item.index {
                changable.index -= 1
            }
        }
        
        item.index = items.count - 1
    }
    
    func bringBack(item: PPItemModel) {
        for changable in items {
            if changable.index < item.index {
                changable.index += 1
            }
        }
        
        item.index = 0
    }
    
}
