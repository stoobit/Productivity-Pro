//
//  PPShapeType.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 01.10.23.
//

import Foundation

enum PPShapeType: String, Codable {
    case line = "line"
    case arrow = "arrow"
    
    case rectangle = "rectangle"
    case triangle = "triangle"
    case circle = "circle"
    case hexagon = "hexagon"
    case multigon = "multigon"
}
