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
    
    func calculatePath(for points: [PPPoint]) -> Path {
        var path = Path()
        
        if let firstPoint = points.first {
            path.move(to: CGPoint(x: firstPoint.x, y: firstPoint.y) * scale)
        }
        
        for index in 1..<points.count {
            let mid = getMidPoint(
                CGPoint(x: points[index - 1].x, y: points[index - 1].x) * scale,
                CGPoint(x: points[index].x, y: points[index].x) * scale
            )
            
            path.addQuadCurve(
                to: mid,
                control: CGPoint(x: points[index - 1].x, y: points[index - 1].x) * scale)
        }
        
        if let last = points.last {
            path.addLine(to: CGPoint(x: last.x, y: last.y) * scale)
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

