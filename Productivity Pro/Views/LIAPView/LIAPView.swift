//
//  LIAPView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.04.24.
//

import SwiftUI

struct LIAPView: View {
    @Environment(\.dismiss) var dismiss
    var parent: String
    
    @AppStorage("ppgrade") var grade: Int = 5
    @AppStorage("ppenglischvocab unlocked") var vocabUnlocked: Bool = false

    var body: some View {
        NavigationStack {
            Form {
                Section("Vokabeln") {
                    VocabularyCard()
                }

                Section("Lektüre") {
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(books) { book in
                                BookCard(
                                    title: book.title, author: book.author,
                                    image: book.image, id: book.iapID
                                )
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollIndicators(.hidden)
                    .safeAreaPadding(.vertical, 12)
                    .safeAreaPadding(.horizontal, 10)
                    .listRowInsets(EdgeInsets())
                }
            }
            .scrollIndicators(.hidden)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen") {
                        dismiss()
                    }
                    .foregroundStyle(.primary)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    LIAPView(parent: "root")
}
