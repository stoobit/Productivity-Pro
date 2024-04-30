//
//  LIAPView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.04.24.
//

import SwiftUI

struct LIAPView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    var parent: String

    @AppStorage("ppgrade") var grade: Int = 5
    @AppStorage("ppenglischvocab unlocked") var vocabUnlocked: Bool = false

    @AppStorage("ppunlockedbooks")
    var unlockedBooks: CodableWrapper<[String]> = .init(value: [])

    var body: some View {
        NavigationStack {
            Form {
                Section("Lektüre") {
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(books) { book in
                                BookCard(book: book)
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollIndicators(.hidden)
                    .safeAreaPadding(.vertical, 12)
                    .safeAreaPadding(.horizontal, 10)
                    .listRowInsets(EdgeInsets())
                }
                
                Section("Vokabeln") {
                    VocabularyCard()
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
