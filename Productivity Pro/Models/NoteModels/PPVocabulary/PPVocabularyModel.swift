//
//  PPVocabularyModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.04.24.
//

import Foundation
import SwiftData

@Model class PPVocabularyModel {
    init(filename: String) {
        self.filename = filename
    }
    
    init() {}
    
    var filename: String = ""
}
