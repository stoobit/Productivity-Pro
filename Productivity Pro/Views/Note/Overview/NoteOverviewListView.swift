//
//  NoteOverviewListStyle.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 12.01.24.
//

import SwiftUI

struct NoteOverviewListView: View {
    @Environment(ToolManager.self) var toolManager

    var contentObject: ContentObject
    var isBookmarked: Bool

    var body: some View {
        if let note = contentObject.note {
            List(pages) { page in
                PageView(
                    note: note,
                    page: page,
                    scale: .constant(0),
                    offset: .constant(.zero),
                    size: CGSize(width: 90, height: 90),
                    highResolution: true
                )
            }
            .listSectionSpacing(0)
            .listStyle(.inset)
        }
    }

    var pages: [PPPageModel] {
        guard var pages = contentObject.note?.pages else { return [] }
        if isBookmarked {
            pages = pages.filter { $0.isBookmarked == true }
        }

        pages.sort(using: SortDescriptor(\.index))
        return pages
    }
}
