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

    var body: some View {
        ZStack {
            Color(
                UIColor.secondarySystemBackground
            )
            .ignoresSafeArea(.all)

            NavigationStack {
                OverviewView(contentObject: contentObject, filter: filter)
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
                        }
                    }
            }
        }
    }
}
