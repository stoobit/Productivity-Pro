//
//  MediaItemViewContainer.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 27.02.24.
//

import SwiftUI

struct MediaItemVContainer: View {
    @State var vuModel: MediaVUModel = .init()
    
    @Bindable var page: PPPageModel
    @Bindable var item: PPItemModel
    @Binding var scale: CGFloat
    
    var preloadModels: Bool
    
    var body: some View {
        if preloadModels {
            vuModel.setModel(from: item)
        }
        
        return ZStack {
            MediaItemView(
                item: item,
                vuModel: vuModel,
                scale: $scale
            )
            .modifier(MediaVUModifier(vuModel: vuModel, item: item))
            .position(
                x: (vuModel.position.x) * scale,
                y: (vuModel.position.y) * scale
            )
            .modifier(
                DragItemModifier(
                    item: item, page: page,
                    position: $vuModel.position,
                    scale: $scale
                )
            )
            
            ToolView(
                page: page,
                item: item,
                position: $vuModel.position,
                size: $vuModel.size,
                scale: $scale
            )
            .zIndex(index)
        }
    }
    
    var index: Double {
        if let items = page.items {
            return Double(items.count + 20)
        } else {
            return 20
        }
    }
}
