//
//  ShapeModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.02.23.
//

import SwiftUI

struct ShapeModel: Codable, Hashable {
    var type: ShapeType
    
    var rotation: Double = 0
    
    var showFill: Bool = true
    var fillColor: Data
    
    var showStroke: Bool = false
    var strokeColor: Data = Color.accentColor.data()
    var strokeWidth: Double = 5
    var strokeStyle: BorderStrokeStyle = .line
    
    var cornerRadius: Double = 0
    
}

enum ShapeType: Codable {
    case rectangle
    case circle
    case triangle
    case hexagon
}
