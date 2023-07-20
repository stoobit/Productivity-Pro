//
//  PPShape.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.07.23.
//

import SwiftUI

struct DrawingShape: Shape {
    let scale: CGFloat
    let points: [CGPoint]
    
    var calculator: PPPathCalculator {
        return PPPathCalculator(scale: scale)
    }
    
    func path(in rect: CGRect) -> Path {
        calculator.calculatePath(for: points)
    }
}
