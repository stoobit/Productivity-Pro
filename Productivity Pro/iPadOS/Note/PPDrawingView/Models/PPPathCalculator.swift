//
//  DrawingEngine.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 18.07.23.
//

import SwiftUI

class PPPathCalculator {
    var scale: CGFloat
    
    init(scale: CGFloat) {
        self.scale = scale
    }
    
    func calculatePath(for points: [CGPoint]) -> Path {
        var path = Path()
        
        if let firstPoint = points.first {
            path.move(to: firstPoint * scale)
        }
        
        for index in 1..<points.count {
            let mid = getMidPoint(
                points[index - 1] * scale, points[index] * scale
            )
            
            path.addQuadCurve(to: mid, control: points[index - 1] * scale)
        }
        
        if let last = points.last {
            path.addLine(to: last * scale)
        }
        
        return path
    }
    
    func getMidPoint(_ point1: CGPoint, _ point2: CGPoint) -> CGPoint {
        let newMidPoint = CGPoint(
            x: (point1.x + point2.x)/2, y: (point1.y + point2.y)/2
        )
        
        return newMidPoint
    }
}

