//
//  ScrollViewContainer.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 27.06.23.
//

import SwiftUI

struct ScrollViewContainer: View {
    @Environment(ToolManager.self) var toolManager
    
    var note: PPNoteModel
    var page: PPPageModel
    var size: CGSize
    
    @State var scale: CGFloat = .zero
    @State var offset: CGPoint = .zero
    @State var isVisible: Bool = false
    
    var body: some View {
        @Bindable var page = page
        
        PPScrollView(
            note: note, page: page, size: size,
            scale: $scale, offset: $offset
        ) {
            Group {
                if isVisible {
                    PageView(
                        note: note, page: page, scale: $scale,
                        offset: $offset, size: size
                    )
                }
            }
            .onAppear { isVisible = true }
            .onDisappear { isVisible = false }
        }
        .modifier(
            OrientationUpdater(isPortrait: page.isPortrait)
        )
    }
    
    func getScale() -> CGFloat {
        var scale: CGFloat = 0
        
        if page.isPortrait {
            scale = size.width / shortSide
        } else {
            scale = size.width / longSide
        }
        
        return scale
    }
}
