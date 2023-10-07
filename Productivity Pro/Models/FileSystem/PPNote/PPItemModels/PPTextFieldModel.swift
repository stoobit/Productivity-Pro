//
//  PPTextFieldModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 01.10.23.
//

import SwiftUI
import SwiftData

@Model final class PPTextFieldModel {
    init() {
        self.strokeStyle = PPStrokeType.line.rawValue
    }
    
    var nsAttributedString: Data = NSAttributedString().toCodable()
    
    var fill: Bool = true
    var fillColor: Data = Color.gray.toCodable()
    
    var stroke: Bool = false
    var strokeColor: Data = Color.accentColor.toCodable()
    var strokeWidth: Double = 5
    var strokeStyle: PPStrokeType.RawValue
    
    var shadow: Bool = false
    var shadowColor: Data = Color.black.toCodable()
    
    var cornerRadius: Double = 0
}

