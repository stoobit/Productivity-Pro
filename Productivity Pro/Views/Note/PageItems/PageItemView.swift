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
    
    var note: PPNoteModel
    var page: PPPageModel
    
    @Binding var scale: CGFloat
    @Binding var offset: CGPoint
    
    var highRes: Bool
    var pdfRendering: Bool
    
    var body: some View {
        ForEach(page.items!) { item in
            
//            ItemView(
//                document: $document,
//                offset: $offset,
//                page: $page,
//                item: $item,
//                toolManager: toolManager,
//                subviewManager: subviewManager,
//                highRes: highRes,
//                pdfRendering: pdfRendering
//            )
            .onTapGesture {
                if subviewManager.showInspector == false {
                    tap(item: item)
                }
            }
            .zIndex(Double(item.index))
            
        }
        .frame(
            width: scale * getFrame().width,
            height: scale * getFrame().height
        )
        .clipShape(Rectangle())
        .scaleEffect(1 / scale)
    }
    
    func tap(item: PPItemModel) {
        toolManager.activeItem = item
        subviewManager.showInspector.toggle()
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
