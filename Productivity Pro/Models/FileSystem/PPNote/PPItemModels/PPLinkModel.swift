//
//  PPLinkModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 01.10.23.
//

import Foundation
import SwiftData

@Model final class PPLinkModel {
    init(linkedObject: UUID) {
        self.linkedObject = linkedObject
        self.type = .medium
    }
    
    var type: PPLinkType
    var linkedObject: UUID
}
