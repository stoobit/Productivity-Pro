//
//  MarkdownTutorialView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 18.12.23.
//

import SwiftUI

struct MarkdownTutorialView: View {
    @State var tab: Int = 1

    var body: some View {
        ZStack {
            Rectangle()
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
                .foregroundStyle(Color.accentColor.gradient)
                .ignoresSafeArea(.all, edges: .all)

            TabView(selection: $tab) {
                MDTIntro()
                    .tag(1)
                Text("Tab Content 2")
                    .tag(2)
            }
            .indexViewStyle(
                .page(backgroundDisplayMode: .always)
            )
            .tabViewStyle(
                .page(indexDisplayMode: .always)
            )
        }
    }
}

#Preview {
    MarkdownTutorialView()
}
