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
                    HStack(spacing: 0) {
                        ForEach(contentObject.note!.pages!) { page in
                           
                        }
                    }
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
            
        } else {
            ContentUnavailableView(
                "Ein Fehler ist aufgetreten.",
                systemImage: "exclamationmark.triangle.fill"
            )
        }
    }
}
