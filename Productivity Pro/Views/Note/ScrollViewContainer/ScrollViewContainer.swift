//
//  ScrollViewContainer.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 27.06.23.
//

import SwiftUI

struct ScrollViewContainer: View {
    var note: PPNoteModel
    var page: PPPageModel
    var size: CGSize
    
    @State var scale: CGFloat = .zero
    @State var offset: CGPoint = .zero
    
    init(
        note: PPNoteModel,
        page: PPPageModel,
        size: CGSize
    ) {
        self.note = note
        self.page = page
        self.size = size
        
        self.scale = getScale()
        self.offset = offset
    }
    
    var body: some View {
        @Bindable var page = page
        
        PPScrollView(
            note: note, page: page, size: size,
            scale: $scale, offset: $offset
        ) {
            PageView(
                note: note, page: page, scale: $scale,
                offset: $offset, size: size
            )
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
