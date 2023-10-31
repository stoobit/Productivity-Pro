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
        self.strokeStyle = PPStrokeType.line.rawValue
    }
    
    var media: Data
    
    var stroke: Bool = false
    var strokeColor: Data = Color.accentColor.data()
    var strokeWidth: Double = 5
    var strokeStyle: PPStrokeType.RawValue
    
    var shadow: Bool = false
    var shadowColor: Data = Color.black.data()
    
    var cornerRadius: Double = 0
    var rotation: Double = 0
}

