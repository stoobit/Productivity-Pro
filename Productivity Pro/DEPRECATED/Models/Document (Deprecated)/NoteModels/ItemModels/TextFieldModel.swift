//
//  TextFieldModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.02.23.
//

import SwiftUI

struct TextFieldModel: Codable, Hashable {
    
    var text: String = ""
    
    var font: String
    var fontSize: Double
    var fontColor: Data
    
    var showFill: Bool = false
    var fillColor: Data = Color.green.data()
    
    var showStroke: Bool = false
    var strokeColor: Data = Color.accentColor.data()
    var strokeWidth: Double = 5
    var strokeStyle: BorderStrokeStyle = .line
    
}
