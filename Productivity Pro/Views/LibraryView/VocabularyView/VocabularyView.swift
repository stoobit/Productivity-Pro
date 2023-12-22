//
//  VocabularyView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 22.12.23.
//

import SwiftUI

struct VocabularyView: View {
    var section: String
    var data: [VocabModel]

    @State var active: VocabModel = VocabModel()
    @State var vocabs: [VocabModel] = []

    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea(.all, edges: [.top, .horizontal])

            GeometryReader { proxy in
                TabView(selection: $active) {
                    ForEach(vocabs, id: \.self) { vocab in
                        VCardView(
                            proxy: proxy,
                            vocab: vocab,
                            active: $active
                        )
                        .containerRelativeFrame([.horizontal, .vertical])
                        .tag(vocab)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
            }
            .navigationTitle("Wortschatz \(section)")
            .onAppear(perform: {
                vocabs = getVocabs()
                active = vocabs[0]
            })
        }
    }

    func getVocabs() -> [VocabModel] {
        return data.filter { $0.section == section }.shuffled()
    }
}
