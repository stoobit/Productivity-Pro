//
//  PageItemView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 08.02.23.
//

import SwiftUI

struct PageItemView: View {
    @Environment(ToolManager.self) var toolManager
    @Environment(SubviewManager.self) var subviewManager
    
    @Bindable var note: PPNoteModel
    @Bindable var page: PPPageModel
    
    @Binding var scale: CGFloat
    
    var preloadModels: Bool
    var body: some View {
        ForEach(page.items!) { item in
            ItemView(
                page: page, item: item, scale: $scale,
                preloadModels: preloadModels
            )
            .onTapGesture {
                tap(item: item)
            }
            .zIndex(Double(item.index))
            .id(toolManager.update)
        }
        .frame(
            width: scale * getFrame().width,
            height: scale * getFrame().height
        )
        .clipShape(Rectangle())
        .scaleEffect(1 / scale)
    }
    
    func tap(item: PPItemModel) {
        if item.id != toolManager.activeItem?.id && subviewManager.showInspector == false {
            toolManager.activeItem = item
        } else if toolManager.activeItem?.type == PPItemType.textField.rawValue && item.id == toolManager.activeItem?.id && subviewManager.showInspector == false {
            subviewManager.rtfEditor.toggle()
        }
    }
    
    func getFrame() -> CGSize {
        var frame: CGSize = .zero
        
        if page.isPortrait {
            frame = CGSize(width: shortSide, height: longSide)
        } else {
            frame = CGSize(width: longSide, height: shortSide)
        }
        
        return frame
    }
}
