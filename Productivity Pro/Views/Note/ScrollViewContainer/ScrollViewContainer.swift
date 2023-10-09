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
    var scrollView: UIScrollView = UIScrollView()
    
    var body: some View {
        Text("<#Placeholder#>")
        
//        PPScrollView(
//            size: size,
//            document: $document,
//            page: $page,
//            toolManager: toolManager,
//            subviewManager: subviewManager,
//            scrollView: scrollView
//        ) {
//            PageView(
//                document: $document,
//                page: $page,
//                offset: $offset,
//                toolManager: toolManager,
//                subviewManager: subviewManager,
//                drawingModel: drawingModel,
//                size: size
//            )
//        }
//        .modifier(
//            OrientationUpdater(isPortrait: page.isPortrait)
//        )
        
    }
}
