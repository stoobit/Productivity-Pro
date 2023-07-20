//
//  ScrollViewWrapper.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 27.06.23.
//

import SwiftUI

struct ScrollViewWrapper: View {
    var size: CGSize
    
    @Environment(\.scenePhase) var scenePhase
    @State private var offset: CGFloat = .zero
    
    @Binding var document: ProductivityProDocument
    @Binding var page: Page
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    @StateObject var drawingModel: PPDrawingModel

    
    var scrollView: UIScrollView = UIScrollView()
    
    var body: some View {
        ZoomableScrollView(
            size: size,
            document: $document,
            page: $page,
            toolManager: toolManager,
            subviewManager: subviewManager,
            scrollView: scrollView
        ) {
            PageView(
                document: $document,
                page: $page,
                offset: $offset,
                toolManager: toolManager,
                subviewManager: subviewManager,
                drawingModel: drawingModel,
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
