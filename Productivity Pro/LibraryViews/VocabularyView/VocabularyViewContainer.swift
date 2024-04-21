//
//  VocabularyViewContainer.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.04.24.
//

import SwiftUI

struct VocabularyViewContainer: View {
    @Environment(\.dismiss) var dismiss
    var object: ContentObject
    
    var body: some View {
        VocabularyList(model: object.vocabulary!)
            .navigationTitle(object.title)
            .toolbarRole(.browser)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    NavigationLink(destination: {}) {
                        Label("Papierkorb", systemImage: "trash")
                    }
                    .tint(Color.red)
                    .disabled(true)
                    
                    NavigationLink(destination: {}) {
                        Label("Suchen", systemImage: "magnifyingglass")
                    }
                    .disabled(true)
                    
                    Button(action: { dismiss() }) {
                        Label("Zurück", systemImage: "chevron.left")
                    }
                    
                    Button(action: {}) {
                        Label("Sortieren", systemImage: "list.bullet")
                    }
                    .disabled(true)
                }
            }
    }
}
