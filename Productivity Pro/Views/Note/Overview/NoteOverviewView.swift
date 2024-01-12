//
//  NoteOverviewView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 03.01.24.
//

import SwiftUI

struct NoteOverviewView: View {
    var contentObject: ContentObject

    @State private var tab: Int = 0

    var body: some View {
        VStack {
            Picker("", selection: $tab) {
                Label("Alle", systemImage: "line.horizontal.3.decrease")
                    .tag(0)

                Label("Lesezeichen", systemImage: "bookmark.fill")
                    .tag(1)
            }
            .labelsHidden()
            .pickerStyle(.segmented)
            .padding()

            TabView(selection: $tab) {
                NoteOverviewListView(
                    contentObject: contentObject,
                    isBookmarked: false
                )
                .tag(0)

                NoteOverviewListView(
                    contentObject: contentObject,
                    isBookmarked: true
                )
                .tag(1)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .scrollIndicators(.hidden)
    }
}
