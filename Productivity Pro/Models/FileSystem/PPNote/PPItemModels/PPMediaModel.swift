//
//  PPMediaModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 01.10.23.
//

import SwiftUI
import SwiftData

@Model final class PPMediaModel {
    init(media: Data) {
        self.media = media
    }
    
    var media: Data
    
    var stroke: Bool = false
    var strokeColor: Data = Color.accentColor.toCodable()
    var strokeWidth: Double = 5
    @Transient var strokeStyle: PPStrokeType = .line
    
    var shadow: Bool = false
    var shadowColor: Data = Color.black.toCodable()
    
    var cornerRadius: Double = 0
    var rotation: Double = 0
}

