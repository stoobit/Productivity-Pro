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
    
    @State var pages: [PPPageModel] = .init()

    var contentObject: ContentObject
    var filter: Bool

    var body: some View {
        ScrollViewReader { reader in
            List {
                ForEach(pages) { page in
                    OverviewRow(contentObject: contentObject, page: page) {
                        if filter {
                            sort()
                        }
                    }
                    .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
                    .moveDisabled(contentObject.note?.pages?.count == 1)
                    .deleteDisabled(contentObject.note?.pages?.count == 1)
                    .id(page.id)
                }
                .onMove(perform: move)
                .onDelete(perform: delete)
                .moveDisabled(filter)
            }
            .scrollContentBackground(.hidden)
            .scrollIndicators(.hidden)
            .background {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea(.all)
            }
            .onChange(of: contentObject.note?.pages) {
                withAnimation(.bouncy) {
                    sort()
                }
            }
            .onChange(of: filter) {
                withAnimation(.bouncy) {
                    sort()
                }
            }
            .onAppear {
                sort()
                reader.scrollTo(toolManager.activePage)
            }
            .overlay {
                if pages.isEmpty {
                    ContentUnavailableView(
                        "Du hast keiner Seite ein Lesezeichen hinzugefügt.", systemImage: "bookmark.slash.fill")
                }
            }
        }
    }

    func sort() {
        if filter == false {
            pages = contentObject.note!.pages!
                .sorted(using: SortDescriptor(\.index))
        } else {
            pages = contentObject.note!.pages!
                .filter(\.isBookmarked)
                .sorted(using: SortDescriptor(\.index))
        }
    }
}
