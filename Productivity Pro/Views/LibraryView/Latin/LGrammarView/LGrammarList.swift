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

            Section("Konjugationen") {
                Label("In Arbeit...", systemImage: "line.3.crossed.swirl.circle.fill")
                    .foregroundStyle(Color.secondary)
                    .frame(height: 30)
            }

            Section("Adjektive") {
                Label("In Arbeit...", systemImage: "line.3.crossed.swirl.circle.fill")
                    .foregroundStyle(Color.secondary)
                    .frame(height: 30)
            }
        }
        .environment(\.defaultMinListRowHeight, 10)
        .navigationTitle("Grammatik")
    }
}
