//
//  LatinView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.12.23.
//

import SwiftUI

struct LatinView: View {
    @State var selection: String = "Vokabeln"

    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea(.all, edges: [.top, .horizontal])

            if selection == "Grammatik" {
                LGrammarList()
            } else if selection == "Vokabeln" {
                LVocabularyList()
            } else if selection == "Geschichte" {
                LHistoryList()
            }
        }
        .navigationTitle("Latein")
        .navigationBarTitleDisplayMode(.inline)
        .tabViewStyle(.page)
        .overlay {
            LTabIndicator(selection: $selection)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .bottom
                )
                .padding(25)
        }
    }
}

#Preview {
    NavigationStack {
        LatinView()
    }
}