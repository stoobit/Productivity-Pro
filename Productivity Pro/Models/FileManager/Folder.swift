//
//  Folder.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.09.23.
//

import Foundation
import SwiftData

@Model final class Folder: Identifiable {
    @Attribute(.unique) public var id: UUID
    
    init(id: UUID, topLevel: Bool, title: String, date: Date, grade: Int) {
        self.id = id
        self.topLevel = topLevel
        self.title = title
        self.date = date
        self.grade = grade
        self.dateChanged = date
    }
    
    var title: String
    var topLevel: Bool
    var date: Date
    var dateChanged: Date
    var grade: Int
    var subject: UUID?
    
    var content: [ContentObject] = []
}
