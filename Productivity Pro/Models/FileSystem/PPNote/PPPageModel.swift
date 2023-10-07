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
        self.type = type
        self.canvas = canvas
        
        self.created = Date()
    }
    
    @Transient var type: PPPageType = .template
    @Transient var canvas: PPCanvasType = .pkCanvas
    
    var title: String = ""
    var created: Date
    
    var template: String = ""
    var color: String = ""
    var isPortrait: Bool = false
    var media: Data? = nil
    
    var ppCanvas: PPCanvasModel?
    var pkCanvas: Data?
 
    @Relationship(deleteRule: .cascade)
    var items: [PPItemModel] = []
}
