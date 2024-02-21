//
//  ItemModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.02.24.
//

import SwiftUI

@Observable class ItemObserver {
    var item: PPItemModel
    
    init(item: PPItemModel) {
        self.item = item
    }
}
