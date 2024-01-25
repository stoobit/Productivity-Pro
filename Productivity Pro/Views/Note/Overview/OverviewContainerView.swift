//
//  OverviewContainerView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.01.24.
//

import SwiftUI

struct OverviewContainerView: View {
    @Environment(SubviewManager.self) var subviewManager
    var contentObject: ContentObject

    @State var filter: Bool = false
    var scrollView: ScrollViewProxy

    var body: some View {
        NavigationStack {
            OverviewView(
                contentObject: contentObject,
                filter: filter,
                scrollView: scrollView
            )
            .navigationTitle("Übersicht")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Fertig") {
                        subviewManager.overview.toggle()
                    }
                    .keyboardShortcut(.return, modifiers: [])
                }

                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        filter.toggle()
                    }) {
                        Label("Filter", systemImage: filter ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
                    }
                    .disabled(
                        contentObject.note!.pages!.filter {
                            $0.isBookmarked == true
                        }.isEmpty
                    )
                }
            }
        }
    }
}
