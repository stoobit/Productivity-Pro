//
//  File.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.23.
//

import Foundation
import SwiftData

@Model final class File {
    @Attribute(.unique) public var id: UUID
    
    init(
        id: UUID,
        title: String,
        date: Date,
        grade: Int,
        document: Document
    ) {
        self.id = id
        self.title = title
        self.date = date
        self.dateChanged = date
        self.grade = grade
        self.document = document
    }
    
    var title: String
    var date: Date
    var dateChanged: Date
    var grade: Int
    
    var document: Document
}
