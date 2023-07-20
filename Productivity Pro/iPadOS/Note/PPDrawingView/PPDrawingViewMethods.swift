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
            
            drawingModel.lines.append(
                PPLine(
                    points: [point],
                    color: drawingModel.selectedColor.getData(),
                    lineWidth: drawingModel.selectedWidth,
                    lineStyle: style
                )
            )
            
        } else {
            
            let index = drawingModel.lines.count - 1
            drawingModel.lines[index].points.append(point)
            
        }
        
    }
    
    func dragDidEnd(value: DragGesture.Value) {
        if let last = drawingModel.lines.last?.points, last.isEmpty {
            drawingModel.lines.removeLast()
        }
    }
    
}
