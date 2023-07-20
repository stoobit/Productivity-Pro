//
//  PPDrawingViewMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.07.23.
//

import SwiftUI

extension PPDrawingView {
    
    func didDrag(value: DragGesture.Value) {
        
        let point = value.location / scale
        if value.translation.width + value.translation.height == 0 {
            
            guard let style = PPLineStyle(rawValue: drawingModel.selectedTool.rawValue) else {
                return
            }
            
            lines?.append(
                PPLine(
                    points: [PPPoint(x: point.x, y: point.y)],
                    color: drawingModel.selectedColor.rawValue,
                    lineWidth: drawingModel.selectedWidth,
                    lineStyle: style
                )
            )
            
        } else {
            
            guard var index = lines?.count else { return }
            index -= 1
            
            lines?[index].points.append(PPPoint(x: point.x, y: point.y))
            
        }
        
    }
    
    func dragDidEnd(value: DragGesture.Value) {
        if let last = lines?.last?.points, last.isEmpty {
            lines?.removeLast()
        }
    }
    
}
