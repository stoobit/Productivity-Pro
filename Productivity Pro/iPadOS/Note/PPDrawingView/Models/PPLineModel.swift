//
//  Line.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 18.07.23.
//

import SwiftUI

struct PPLine: Identifiable, Codable, Hashable {
    var id = UUID()
    
    var points: [PPPoint]
    
    var color: String
    var lineWidth: CGFloat
    var lineStyle: PPLineStyle

}

struct PPPoint: Identifiable, Codable, Hashable {
    var id = UUID()
    
    var x: Double
    var y: Double
}

enum PPLineStyle: String, Codable {
    case pen = "pen"
    case highlighter = "highlighter"
}
