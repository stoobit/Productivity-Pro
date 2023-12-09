//
//  StackingModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.12.23.
//

import SwiftUI

struct StackingModel {
    var items: [PPItemModel]
    
    func moveUp(item: PPItemModel) {
        item.index = 1000
    }
    
    func moveDown(item: PPItemModel) {
        
    }
    
    func bringFront(item: PPItemModel) {
        
    }
    
    func bringBack(item: PPItemModel) {
        
    }
    
}
