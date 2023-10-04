//
//  PPShapeModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 01.10.23.
//

import SwiftUI
import SwiftData

@Model final class PPShapeModel {
    init(type: PPShapeType) {
        self.type = type
        self.strokeStyle = .line
    }
    
    var type: PPShapeType
    
    var fill: Bool = true
    var fillColor: Data = Color.gray.toCodable()
    
    var stroke: Bool = false
    var strokeColor: Data = Color.accentColor.toCodable()
    var strokeWidth: CGFloat = 5
    var strokeStyle: PPStrokeType
    
    var shadow: Bool = false
    var shadowColor: Data = Color.black.toCodable()
    
    var cornerRadius: CGFloat = 0
    var rotation: CGFloat = 0
    
}
