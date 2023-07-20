//
//  Line.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 18.07.23.
//

import SwiftUI

struct PPLine: Identifiable, Codable {
    var id = UUID()
    
    var points: [CGPoint]
    
    var color: String
    var lineWidth: CGFloat
    var lineStyle: PPLineStyle

}

enum PPLineStyle: String, Codable {
    case pen = "pen"
    case highlighter = "highlighter"
}
