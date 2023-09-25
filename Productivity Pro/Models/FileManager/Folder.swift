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
    
    init(id: UUID, title: String, date: Date, grade: Int) {
        self.id = id
        self.title = title
        self.date = date
        self.grade = grade
        self.dateChanged = date
    }
    
    var title: String
    var topLevel: Bool = false
    var date: Date
    var dateChanged: Date
    var grade: Int
    var subject: UUID?
    
    var content: [ContentObject] = []
}
