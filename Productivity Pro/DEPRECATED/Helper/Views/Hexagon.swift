//
//  Hexagon.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 16.02.23.
//

import SwiftUI

struct Hexagon: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(
            to: CGPoint(x: rect.minX, y: rect.midY)
        )
        path.addLine(
            to: CGPoint(x: (rect.minX + rect.midX) / 2, y: rect.maxY)
        )
        path.addLine(
            to: CGPoint(x: (rect.maxX + rect.midX) / 2, y: rect.maxY)
        )
        path.addLine(
            to: CGPoint(x: rect.maxX, y: rect.midY)
        )
        path.addLine(
            to: CGPoint(x: (rect.maxX + rect.midX) / 2, y: rect.minY)
        )
        path.addLine(
            to: CGPoint(x: (rect.minX + rect.midX) / 2, y: rect.minY)
        )

        path.closeSubpath()
        
        return path
    }
}
