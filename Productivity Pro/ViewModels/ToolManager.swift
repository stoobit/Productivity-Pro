//
//  ToolManager.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 08.11.22.
//

import SwiftUI

@Observable final class ToolManager {
    var selectedContentObject: ContentObject?
    
    var activePage: PPPageModel?
    var selectedPages: [PPPageModel] = []
    
    var activeItem: PPItemModel?
    var selectedItems: [PPItemModel] = []
    
    var frameVisible: Bool = true
    var editorVisible: Bool = true
    var dragType: DragType = .none
    
    var showSnapper: [Bool] = [false, false]
    var showProgress: Bool = false
    
    var pencilKit: Bool = false
    
    var scale: CGFloat = .zero
    var offset: CGPoint = .zero
    
    var update: Int = 0
}
