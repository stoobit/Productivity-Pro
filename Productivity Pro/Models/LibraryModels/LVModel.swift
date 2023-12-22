//
//  LVModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 13.12.23.
//

import Foundation


struct LVModel: Codable, Hashable, VocabModel {
    var latin: String = ""
    var german: String = ""
    var section: String = ""
    
    func getWord() -> String {
        return latin
    }
    
    func getTranslation() -> String {
        return german
    }
    
    func getSection() -> String {
        return section
    }
}
