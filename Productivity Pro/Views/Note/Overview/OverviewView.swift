//
//  OverviewView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 03.10.22.
//

import SwiftUI

struct OverviewView: View {
    @Environment(ToolManager.self) var toolManager
    @Environment(SubviewManager.self) var subviewManager

    @State var pages: [PPPageModel]
    var contentObject: ContentObject

    init(contentObject: ContentObject) {
        self.contentObject = contentObject

        pages = contentObject.note!.pages!
            .sorted(by: { $0.index < $1.index })
    }

    var body: some View {
        NavigationStack {
            ScrollViewReader { _ in
                List {
                    ForEach(pages) { page in
                        OverviewRow(contentObject: contentObject, page: page)
                            .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
                            .moveDisabled(contentObject.note?.pages?.count == 1)
                            .deleteDisabled(contentObject.note?.pages?.count == 1)
                            .id(page.id)
                    }
                    .onMove(perform: move)
                    .onDelete(perform: delete)
                }
            }
            .navigationTitle("Übersicht")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.browser)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Fertig") {
                        subviewManager.overview.toggle()
                    }
                    .keyboardShortcut(.return, modifiers: [])
                }
            }
        }
    }
}
