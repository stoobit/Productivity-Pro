//
//  PPNoteModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.09.23.
//

import Foundation
import SwiftData

@Model final class PPNoteModel {
    var type: PPNoteType
    var contentObject: ContentObject
    
    init(
        type: PPNoteType = .standard,
        contentObject: ContentObject
    ) {
        self.type = type
        self.contentObject = contentObject
    }
    
    @Relationship(inverse: \PPPageModel.note)
    var pages: [PPPageModel] = []
}

enum PPNoteType: Codable {
    case standard
    case whiteboard
    case markdown
    case reality
}
