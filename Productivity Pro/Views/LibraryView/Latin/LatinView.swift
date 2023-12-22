//
//  LatinView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.12.23.
//

import SwiftUI

struct LatinView: View {
    @State var selection: String = "Grammatik"

    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea(.all, edges: [.top, .horizontal])
            
            TabView(selection: $selection) {
                LGrammarList()
                    .tag("Grammatik")
                LVocabularyList()
                    .tag("Vokabeln")
                LHistoryList()
                    .tag("Geschichte")
            }
        }
        .tabViewStyle(.page)
        .overlay {
            LTabIndicator(selection: $selection)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .bottom
                )
                .padding(10)
        }
    }
}

#Preview {
    NavigationStack {
        LatinView()
    }
}
