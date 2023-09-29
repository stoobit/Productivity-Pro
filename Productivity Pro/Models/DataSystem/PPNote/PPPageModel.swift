//
//  PPPage.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.09.23.
//

import SwiftUI
import SwiftData

@Model final class PPPageModel: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var note: PPNoteModel
    
    init(
        note: PPNoteModel,
        type: PPPageType,
        canvas: PPCanvasType
    ) {
        self.note = note
        self.type = type
        self.canvas = canvas
        
        self.created = Date()
    }
    
    var type: PPPageType
    var canvas: PPCanvasType
    
    var header: String = ""
    var created: Date
    
    var template: String = ""
    var color: Data = Color.white.toCodable()
    var isPortrait: Bool = false
    var media: Data? = nil
    
    @Relationship(inverse: \PPCanvasModel.page)
    var ppCanvas: PPCanvasModel?
    var pkCanvas: Data = Data()
 
    @Relationship(inverse: \PPItemModel.page)
    var items: [PPItemModel] = []
}

enum PPPageType: Int, Codable {
    case none = 0
    
    case template = 1
    case pdf = 2
    case image = 3
    case mindmap = 4
}

enum PPCanvasType: Int, Codable {
    case pkCanvas = 0
    case ppCanvas = 1
}
