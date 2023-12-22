//
//  VocabModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 22.12.23.
//

import Foundation

protocol VocabModel {
    func getWord() -> String
    func getTranslation() -> String
    func getSection() -> String
}
