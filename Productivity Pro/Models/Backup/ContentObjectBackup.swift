//
//  ContentObjectBackup.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.23.
//

import Foundation

struct ContentObjectBackup: Identifiable, Codable {
    var id: UUID
    
    var title: String
    var type: ContentObjectType
    var parent: String
    
    var created: Date
    var modified: Date
    
    var grade: Int
    var subject: UUID?
    
    var document: Document?
    var isPinned: Bool
}
