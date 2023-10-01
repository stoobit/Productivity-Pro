//
//  PPTextFieldModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 01.10.23.
//

import SwiftUI
import SwiftData

@Model final class PPTextFieldModel {
    init(fontSize: CGFloat, fontColor: Color) {
        self.strokeStyle = .line
        
        self.fontSize = fontSize
        self.fontColor = fontColor.toCodable()
    }
    
    var text: String = ""
    
    var fontName: String = "Avenir Next"
    var fontSize: CGFloat
    var fontColor: Data
    
    var fill: Bool = true
    var fillColor: Data = Color.gray.toCodable()
    
    var stroke: Bool = false
    var strokeColor: Data = Color.accentColor.toCodable()
    var strokeWidth: CGFloat = 5
    var strokeStyle: PPStrokeStyle
    
}

