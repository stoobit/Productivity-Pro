//
//  ExportableShapeModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 04.10.23.
//

import Foundation

struct ExportableShapeModel: Codable {
    var type: PPShapeType
    
    var fill: Bool
    var fillColor: Data
    
    var stroke: Bool
    var strokeColor: Data
    var strokeWidth: CGFloat
    var strokeStyle: PPStrokeStyle
    
    var shadow: Bool
    var shadowColor: Data
    
    var cornerRadius: CGFloat
    var rotation: CGFloat
}
