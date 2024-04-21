//
//  VocabularyView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 22.12.23.
//

import SwiftUI

struct VocabularyView: View {
    var section: String
    var data: [PPVocabularyItem]

    @State var active: PPVocabularyItem?
    @State var vocabs: [PPVocabularyItem] = []

    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea(.all, edges: [.top, .horizontal])

            GeometryReader { proxy in
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 0) {
                        ForEach(vocabs, id: \.self) { vocab in
                            VCardView(
                                proxy: proxy,
                                vocab: vocab,
                                active: $active,
                                index: index(of: vocab)
                            )
                            .containerRelativeFrame([.horizontal, .vertical])
                            .scrollTransition(
                                .interactive, axis: .horizontal
                            ) { content, phase in
                                content
                                    .scaleEffect(phase.isIdentity ? 1.0 : 0.1)
                            }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.paging)
                .scrollIndicators(.hidden)
                .scrollPosition(id: $active)
            }
            .navigationTitle("Wortschatz \(section)")
            .onAppear(perform: {
                vocabs = getVocabs()
                active = vocabs[0]
            })
        }
    }

    func getVocabs() -> [PPVocabularyItem] {
        return data.filter { $0.section == section }.shuffled()
    }
    
    func index(of model: PPVocabularyItem) ->  String {
        return "\((vocabs.firstIndex(of: model) ?? 0) + 1) / \(vocabs.count)"
    }
}
