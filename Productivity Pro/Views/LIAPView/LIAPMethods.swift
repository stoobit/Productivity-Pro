//
//  LIAPMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.04.24.
//

import SwiftUI

extension LIAPView {
    func addVocabulary() {
        withAnimation {
            let contentObject = ContentObject(
                id: UUID(),
                title: "Latein Vokabeln",
                type: .vocabulary,
                parent: parent,
                created: Date(),
                grade: grade
            )
            
            let vocabulary = PPVocabularyModel(filename: "latinvocabulary")
            contentObject.vocabulary = vocabulary
            
            context.insert(contentObject)
        }
    }
}
