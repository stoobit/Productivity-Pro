//
//  VocabularyView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 22.12.23.
//

import SwiftUI

struct VocabularyView: View {
    var section: String
    var vocabularies: [VocabModel]

    var body: some View {
        GeometryReader { proxy in
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(vocabularies, id: \.self) { vocab in
                        VCardView(proxy: proxy, vocab: vocab)
                            .containerRelativeFrame([.horizontal, .vertical])
                            .scrollTransition(
                                .interactive, axis: .horizontal
                            ) { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1.0 : 0.5)
                                    .scaleEffect(phase.isIdentity ? 1.0 : 0.1)
                                    .blur(radius: phase.isIdentity ? 0 : 50)
                            }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.paging)
            .scrollIndicators(.hidden)
        }
        .navigationTitle("Wortschatz \(section)")
    }
}
