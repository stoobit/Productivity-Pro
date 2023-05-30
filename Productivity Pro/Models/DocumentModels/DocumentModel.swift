//
//  DocumentModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 15.09.22.
//

import Foundation

struct Document: Codable {
    var url: URL?
    
    var documentType: DocumentType = .none
    
    var note: Note!
    var whiteboard: Whiteboard!
    var taskList: TaskList!
    
}

enum DocumentType: Codable {
    case none
    case note
    case whiteboard
    case taskList
}
