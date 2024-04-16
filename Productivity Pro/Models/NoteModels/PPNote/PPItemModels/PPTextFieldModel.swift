//
//  PPTextFieldModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 01.10.23.
//

import SwiftData
import SwiftUI

@Model final class PPTextFieldModel {
    init() {
        self.text = NSAttributedString().data()
    }
    
    init(text: NSAttributedString) {
        self.text = text.data()
    }
    
    init(text: Data) {
        self.text = text
    }
    
    var text: Data
    
    // MARK: text attributes

    var string: String = ""
    var textColor: Data = Color.black.data()
    var fontName: String = "Avenir Next"
    var fontSize: Double = 13
    
    // MARK: box attributes

    var fill: Bool = false
    var fillColor: Data = Color.green.data()
    var stroke: Bool = false
    var strokeColor: Data = Color.accentColor.data()
    var strokeWidth: Double = 10
    var strokeStyle: PPStrokeType.RawValue = PPStrokeType.line.rawValue
    
    var shadow: Bool = false
    var shadowColor: Data = Color.black.data()
    
    var cornerRadius: Double = 0
    var rotation: Double = 0
}
