//
//  VocabModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 22.12.23.
//

import Foundation

struct VocabModel: Codable, Hashable {
    var word: String = ""
    var translation: String = ""
    var section: String = ""
}
