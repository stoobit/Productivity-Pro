//
//  ItemView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 20.05.23.
//

import SwiftUI

struct ItemView: View {
    @Environment(ToolManager.self) var toolManager
    @Environment(SubviewManager.self) var subviewManager
    
    @Bindable var page: PPPageModel
    @Bindable var item: PPItemModel
    
    @Binding var scale: CGFloat
    
    var realrenderText: Bool
    var preloadModels: Bool
    
    var body: some View {
        if item.type == PPItemType.shape.rawValue {
            ShapeItemViewContainer(
                page: page,
                item: item,
                scale: $scale,
                realrenderText: realrenderText,
                preloadModels: preloadModels
            )
        } else if item.type == PPItemType.media.rawValue {
            MediaItemVContainer(
                page: page,
                item: item,
                scale: $scale,
                realrenderText: realrenderText,
                preloadModels: preloadModels
            )
        } else if item.type == PPItemType.textField.rawValue {
            TextfieldItemVContainer(
                page: page,
                item: item,
                scale: $scale,
                realrenderText: realrenderText,
                preloadModels: preloadModels
            )
        }
    }
}
