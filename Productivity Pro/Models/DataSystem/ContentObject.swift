//
//  ContentObject.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.23.
//

import Foundation
import SwiftData

@Model final class ContentObject: Identifiable {
    
    init(
        id: UUID,
        title: String,
        type: ContentObjectType,
        parent: String,
        created: Date,
        grade: Int,
        subject: UUID? = nil
    ) {
        self.id = id
        self.title = title
        self.parent = parent
        self.type = type
        self.created = created
        self.modified = created
        self.grade = grade
        self.subject = subject
    }
    
    @Attribute(.unique) public var id: UUID
    
    var title: String
    var type: ContentObjectType
    var parent: String
    
    var created: Date
    var modified: Date
    
    var grade: Int
    var subject: UUID?
    
    var isPinned: Bool = false
    var inTrash: Bool = false
    
    @Relationship(inverse: \PPNoteModel.contentObject)
    var note: ContentObject?
}

enum ContentObjectType: Comparable, Codable {
    case file
    case folder
}
