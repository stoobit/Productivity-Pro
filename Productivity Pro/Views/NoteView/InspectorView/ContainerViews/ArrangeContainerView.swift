//
//  ArrangeContainerView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 20.10.23.
//

import SwiftUI

struct ArrangeContainerView: View {
    @Environment(ToolManager.self) var toolManager
    
    typealias item = PPItemType
    var hsc: UserInterfaceSizeClass?
    
    @Bindable var contentObject: ContentObject
    
    var body: some View {
        
        if toolManager.activeItem?.type == item.shape.rawValue {
            ShapeArrangeView(items: items)
        } else if toolManager.activeItem?.type == item.media.rawValue {
            MediaArrangeView(items: items)
        }  else if toolManager.activeItem?.type == item.textField.rawValue {
            TextFieldArrangeView(items: items)
        } else {
            ProgressView()
        }
    }
    
    var items: [PPItemModel] {
        return contentObject.note!.pages!.first(where: {
            $0.id == toolManager.activePage?.id
        })!.items!
    }
}
