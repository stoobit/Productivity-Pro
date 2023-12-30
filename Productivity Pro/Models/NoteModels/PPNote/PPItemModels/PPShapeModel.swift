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
        self.type = type.rawValue
        self.strokeStyle = PPStrokeType.line.rawValue
    }
    
    var type: PPShapeType.RawValue = ""
    
    var fill: Bool = true
    var fillColor: Data = Color.gray.data()
    
    var stroke: Bool = false
    var strokeColor: Data = Color.accentColor.data()
    var strokeWidth: Double = 10
    var strokeStyle: PPStrokeType.RawValue
    
    var shadow: Bool = false
    var shadowColor: Data = Color.black.data()
    
    var cornerRadius: Double = 0
    var rotation: Double = 0
    
}
