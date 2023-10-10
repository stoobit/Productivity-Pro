//
//  NoteView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.22.
//

import SwiftUI

struct NoteView: View {
    @Environment(ToolManager.self) var toolManager
    @Environment(SubviewManager.self) var subviewManager
    @State var activePage: PPPageModel?
    
    var contentObject: ContentObject
    
    var body: some View {
        if contentObject.note?.pages != nil {
            @Bindable var subviewValue = subviewManager
            
            GeometryReader { proxy in
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 0) {
                        ForEach(contentObject.note!.pages!) { page in
                            ScrollViewContainer(
                                note: contentObject.note!,
                                page: page,
                                size: proxy.size
                            )
                            .containerRelativeFrame(
                                [.horizontal, .vertical]
                            )
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.paging)
                .scrollPosition(id: $activePage)
                .onChange(of: activePage, initial: true) { last, active in
                    if let page = active {
                        toolManager.activePage = page
                    } else {
                        toolManager.activePage = contentObject.note!.pages!.first!
                    }
                }
            }
            .noteViewModifier(with: contentObject)
            .background {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea(.all)
            }
            .inspector(isPresented: $subviewValue.showStylePopover) {
                Text("hi")
            }
            
        } else {
            ContentUnavailableView(
                "Ein Fehler ist aufgetreten.",
                systemImage: "exclamationmark.triangle.fill"
            )
        }
    }
    
//    func pageIndicator() {
//            if subviewManager.overviewSheet == false {
//                toolManager.isPageNumberVisible = true
//    
//                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                    withAnimation {
//                        toolManager.isPageNumberVisible = false
//                    }
//                }
//            }
//        }
}
