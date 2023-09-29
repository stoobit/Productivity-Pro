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
    
    init(type: PPNoteType = .standard) {
        self.type = type
    }
    
    
}
