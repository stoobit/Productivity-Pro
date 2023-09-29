//
//  PPCanvasModels.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.09.23.
//

import Foundation
import SwiftData

@Model final class PPCanvasModel {
    @Attribute(.unique) public var id: UUID = UUID()
    var page: PPPageModel
    
    init(page: PPPageModel) {
        self.page = page
    }
    
}
