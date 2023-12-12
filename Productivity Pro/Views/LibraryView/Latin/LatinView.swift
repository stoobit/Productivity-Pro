//
//  LatinView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.12.23.
//

import SwiftUI

struct LatinView: View {
    var body: some View {
        Form {
            
            Section {
                DisclosureGroup(content: {
                    LGrammarList()
                }) {
                    Label("Grammatik", systemImage: "text.word.spacing")
                        .frame(height: 30)
                }
            }
            
            Section {
                DisclosureGroup(content: {
                    LVocabularyList()
                }) {
                    Label("Vokabeln", systemImage: "textformat.abc")
                        .frame(height: 30)
                }
            }
            
            Section {
                DisclosureGroup(content: {
                    LHistoryList()
                }) {
                    Label("Geschichtliche Informationen", systemImage: "clock")
                        .frame(height: 30)
                }
            }
            
        }
        .listSectionSpacing(10)
        .environment(\.defaultMinListRowHeight, 10)
        .navigationTitle("Latein")
    }
}

#Preview {
    LatinView()
}
