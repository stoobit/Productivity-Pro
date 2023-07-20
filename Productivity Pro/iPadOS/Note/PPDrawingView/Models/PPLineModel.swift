//
//  Line.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 18.07.23.
//

import SwiftUI

struct PPLine: Identifiable, Codable, Hashable {
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

extension CGPoint: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
}
