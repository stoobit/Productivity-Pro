//
//  ScrollViewContainer.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 27.06.23.
//

import SwiftUI

@MainActor
struct ScrollViewContainer: View {
    @Environment(ToolManager.self) var toolManager
    @Environment(PagingViewModel.self) var pvModel
    
    @Bindable var note: PPNoteModel
    @Bindable var page: PPPageModel
    
    var proxy: GeometryProxy
    
    @State var scale: CGFloat = .zero
    @State var offset: CGPoint = .zero
    
    let scrollView = UIScrollView()
    var body: some View {
        PPScrollView(
            scrollView: scrollView, isPortrait: page.isPortrait,
            proxy: proxy, scale: $scale, offset: $offset
        ) {
            PageView(
                note: note, page: page,
                scale: $scale, offset: $offset, size: proxy.size
            )
        }
        .modifier(OrientationUpdater(isPortrait: page.isPortrait))
        .onChange(of: pvModel.index) {
            if pvModel.index == page.index {
                toolManager.scale = scale
                toolManager.offset = offset
            }
        }
    }
}
