//
//  PPTextFieldModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 01.10.23.
//

import SwiftUI
import SwiftData

@Model final class PPTextFieldModel {
    init(textColor: Color, font: String, fontSize: Double) {
        self.strokeStyle = PPStrokeType.line.rawValue
        
        self.textColor = textColor.data()
        self.fontName = font
        self.fontSize = fontSize
    }
    
    var string: String = ""
    var textColor: Data
    
    var fontName: String
    var fontSize: Double
    
    var fill: Bool = false
    var fillColor: Data = Color.green.data()
    
    var stroke: Bool = false
    var strokeColor: Data = Color.accentColor.data()
    var strokeWidth: Double = 10
    var strokeStyle: PPStrokeType.RawValue
    
    var shadow: Bool = false
    var shadowColor: Data = Color.black.data()
    
    var cornerRadius: Double = 0
    var rotation: Double = 0
}

