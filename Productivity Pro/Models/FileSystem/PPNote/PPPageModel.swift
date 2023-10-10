//
//  PPPage.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.09.23.
//

import SwiftUI
import SwiftData
import PencilKit

@Model final class PPPageModel: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    
    @Relationship(inverse: \PPNoteModel.pages)
    var note: PPNoteModel?
    
    init(
        type: PPPageType,
        canvas: PPCanvasType
    ) {
        self.type = type.rawValue
        self.canvas = canvas.rawValue
        
        self.created = Date()
    }
    
    var type: PPPageType.RawValue
    var canvas: PPCanvasType.RawValue
    
    var title: String = ""
    var created: Date
    var isBookmarked: Bool = false
    
    var template: String = ""
    var color: String = ""
    var isPortrait: Bool = false
    var media: Data? = nil
    
    var ppCanvas: PPCanvasModel?
    var pkCanvas: Data?
 
    @Relationship(deleteRule: .cascade)
    var items: [PPItemModel]? = []
}
