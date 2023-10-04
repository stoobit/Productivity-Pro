//
//  ExportableTextFieldModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 04.10.23.
//

import Foundation

struct ExportableTextFieldModel: Codable {
    var nsAttributedString: Data
    
    var fontName: String
    var fontSize: CGFloat
    var fontColor: Data
    
    var fill: Bool
    var fillColor: Data
    
    var stroke: Bool = false
    var strokeColor: Data
    var strokeWidth: CGFloat
    var strokeStyle: PPStrokeType
    
    var shadow: Bool
    var shadowColor: Data
    
    var cornerRadius: CGFloat
}
