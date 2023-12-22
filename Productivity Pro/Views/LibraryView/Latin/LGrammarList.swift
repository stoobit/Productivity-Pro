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
            Section("Deklinationen") {
                
            }
            
            Section("Konjugationen") {
                
            }
            
            Section("Adjektive") {
                
            }
        }
        .environment(\.defaultMinListRowHeight, 10)
        .navigationTitle("Grammatik")
    }
}

#Preview {
    LGrammarList()
}
