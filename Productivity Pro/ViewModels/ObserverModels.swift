//
//  ItemModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.02.24.
//

import SwiftUI

struct ItemObserver {
    var page: PPPageModel!
    var item: PPItemModel!

    var shape: PPShapeModel!
    var media: PPMediaModel!
    var textfield: PPTextFieldModel!
    
    init(page: PPPageModel) {
        self.page = page
    }
    
    init(item: PPItemModel) {
        self.item = item
    }
    
    init(shape: PPShapeModel) {
        self.shape = shape
    }
    
    init(media: PPMediaModel) {
        self.media = media
    }
    
    init(textfield: PPTextFieldModel) {
        self.textfield = textfield
    }
}
