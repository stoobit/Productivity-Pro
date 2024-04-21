//
//  PPVocabularyItem.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.04.24.
//

import Foundation

struct PPVocabularyItem: Codable, Hashable {
    var word: String = ""
    var translation: String = ""
    var section: String = ""
}
