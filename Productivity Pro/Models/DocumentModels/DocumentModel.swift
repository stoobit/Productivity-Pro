//
//  DocumentModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 15.09.22.
//

import Foundation

struct Document: Codable {
    var url: URL = .applicationDirectory
    var documentType: DocumentType = .none
    
    var note: Note!
    var realityNote: RealityNote!
}

enum DocumentType: Codable {
    case none
    
    case note
    case realityNote
}
