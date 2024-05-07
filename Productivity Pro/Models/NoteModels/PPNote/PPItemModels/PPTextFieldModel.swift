//
//  PPTextFieldModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 01.10.23.
//

import SwiftData
import SwiftUI

@Model final class PPTextFieldModel {
    init(NSAttributesString: NSAttributedString) {
        self.attributedString = NSAttributesString.data()
    }
    
    var attributedString: Data?
    
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
    
    // MARK: - Old Text Values | Deprecated
    
    @available(*, deprecated, message: "Productivity Pro does not support Markdown anymore. Please use NSAttributedString and the new initializers instead.")
    init(textColor: Color, font: String, fontSize: Double) {
        self.strokeStyle = PPStrokeType.line.rawValue
        
        self.textColor = textColor.data()
        self.fontName = font
        self.fontSize = fontSize
    }
    
    @available(*, deprecated, message: "Productivity Pro does not support Markdown anymore. Please use NSAttributedString and the new initializers instead.")
    init() {
        self.strokeStyle = PPStrokeType.line.rawValue
        self.textColor = Color.black.data()
        self.fontName = "Avenir Next"
        self.fontSize = 13
    }

    @available(*, deprecated, message: "Productivity Pro does not support Markdown anymore. Please use NSAttributedString instead.")
    var string: String = ""
    
    @available(*, deprecated, message: "Productivity Pro does not support Markdown anymore. Please use NSAttributedString instead.")
    var textColor: Data = Color.black.data()
    
    @available(*, deprecated, message: "Productivity Pro does not support Markdown anymore. Please use NSAttributedString instead.")
    var fontName: String = "Avenir Next"
    
    @available(*, deprecated, message: "Productivity Pro does not support Markdown anymore. Please use NSAttributedString instead.")
    var fontSize: Double = 13
}
