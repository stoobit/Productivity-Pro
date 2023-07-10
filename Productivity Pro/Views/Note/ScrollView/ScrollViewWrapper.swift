//
//  ScrollViewWrapper.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 27.06.23.
//

import SwiftUI

struct ScrollViewWrapper: View {
    var size: CGSize
    
    @State private var offset: CGFloat = .zero
    
    @Binding var document: ProductivityProDocument
    @Binding var page: Page
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    var body: some View {
        ZoomableScrollView(
            size: size,
            document: $document,
            page: $page,
            toolManager: toolManager,
            subviewManager: subviewManager
        ) {
            PageView(
                document: $document,
                page: $page,
                offset: $offset,
                toolManager: toolManager,
                subviewManager: subviewManager,
                size: size
            )
        }
        .modifier(
            OrientationUpdater(isPortrait: $page.isPortrait)
        )
        .overlay(
            OffsetProxy()
        )
        .onPreferenceChange(OffsetKey.self) { offset in
            self.offset = offset
        }
        
    }
}
