//
//  LGrammarList.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 13.12.23.
//

import SwiftUI

struct LGrammarList: View {

    var body: some View {
        List {
            Section("Substantive") {
                LGrammarNouns()
            }

            Section("Konjugationen") {}

            Section("Adjektive") {}
        }
        .environment(\.defaultMinListRowHeight, 10)
        .navigationTitle("Grammatik")
    }
}
