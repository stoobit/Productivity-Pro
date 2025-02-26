//
//  OverviewView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 03.10.22.
//

import SwiftUI

struct OverviewView: View {
    @Environment(ToolManager.self) var toolManager
    @Environment(PagingViewModel.self) var pvModel

    var contentObject: ContentObject
    var filter: Bool

    var body: some View {
        ScrollViewReader { reader in
            List {
                Section(pages.isEmpty ? "" : "Pages") {
                    ForEach(pages) { page in
                        OverviewRow(contentObject: contentObject, page: page)
                            .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
                            .deleteDisabled(contentObject.note?.pages?.count == 1)
                            .id(page.id)
                    }
                    .onDelete(perform: delete)
                }
            }
            .scrollContentBackground(.hidden)
            .scrollIndicators(.hidden)
            .background {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea(.all)
            }
            .onAppear {
                reader.scrollTo(toolManager.activePage?.id)
            }
            .overlay {
                if pages.isEmpty {
                    ContentUnavailableView(
                        "You haven't added any bookmarks yet.", systemImage: "bookmark.slash.fill"
                    )
                    .transition(
                        .asymmetric(insertion: .opacity, removal: .identity)
                    )
                }
            }
        }
    }

    
    var pages: [PPPageModel] {
        if filter == false {
            return contentObject.note!.pages!
                .sorted(using: SortDescriptor(\.index))
        } else {
            return contentObject.note!.pages!
                .filter(\.isBookmarked)
                .sorted(using: SortDescriptor(\.index))
        }
    }
}
