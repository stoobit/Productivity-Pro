//
//  ExportableContentObjectModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.12.23.
//

import Foundation

struct ExportableContentObjectModel: Identifiable, Codable {
    var id: UUID
    var type: COType.RawValue
    
    var title: String
    var parent: String
    
    var created: Date
    var modified: Date
    
    var grade: Int
    var subject: UUID?
    
    var isPinned: Bool
    var inTrash: Bool
    
    var note: ExportableNoteModel?
}
