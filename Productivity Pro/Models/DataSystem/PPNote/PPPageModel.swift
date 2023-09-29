//
//  PPPage.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.09.23.
//

import Foundation
import SwiftData

@Model final class PPPageModel: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var note: PPNoteModel
    
    init(note: PPNoteModel) {
        self.note = note
    }
}
