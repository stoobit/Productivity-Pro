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
        TabView(selection: $tab) {
            MDTIntro()
                .tag(1)
            MDTBold()
                .tag(2)
        }
        .indexViewStyle(
            .page(backgroundDisplayMode: .always)
        )
        .tabViewStyle(
            .page(indexDisplayMode: .always)
        )
        .background {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all, edges: .all)
                .foregroundStyle(Color.accentColor.gradient)
        }
    }
}

#Preview {
    MarkdownTutorialView()
}
