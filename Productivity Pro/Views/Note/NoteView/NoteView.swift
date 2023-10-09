//
//  NoteView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.22.
//

import SwiftUI
import PencilKit
import PDFKit

struct NoteView: View {
    @Environment(ToolManager.self) var toolManager
    var contentObject: ContentObject
    
    @State var activePage: PPPageModel?
    
    var body: some View {
        if contentObject.note?.pages != nil {
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
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .background {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea(.all)
            }
            .overlay {
                
            }
            
        } else {
            ContentUnavailableView(
                "Ein Fehler ist aufgetreten.",
                systemImage: "exclamationmark.triangle.fill"
            )
        }
    }
}
