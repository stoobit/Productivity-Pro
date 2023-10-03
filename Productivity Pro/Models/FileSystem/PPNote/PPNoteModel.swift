//
//  PPNoteModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.09.23.
//

import Foundation
import SwiftData

@Model final class PPNoteModel {
    init() {}
    
    @Relationship(deleteRule: .cascade)
    var pages: [PPPageModel]? = []
}
