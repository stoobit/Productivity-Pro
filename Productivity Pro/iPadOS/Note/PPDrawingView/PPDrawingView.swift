//
//  PPDrawingView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 18.07.23.
//

import SwiftUI

struct PPDrawingView: View {
    @StateObject var drawingModel: PPDrawingModel
    
    var scale: CGFloat = 1
    var frame: CGSize
    
    var body: some View {
        ZStack {
            Color.clear.contentShape(Rectangle())
            
            ForEach(drawingModel.lines) { line in
                DrawingShape(scale: scale, points: line.points)
                    .stroke(
                        Color(data: line.color),
                        style: StrokeStyle(
                            lineWidth: line.lineWidth * scale,
                            lineCap: .round,
                            lineJoin: .round
                        )
                    )
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged { value in didDrag(value: value) }
                .onEnded { value in dragDidEnd(value: value) }
        )
        .frame(
            width: scale * frame.width,
            height: scale * frame.height
        )
        .scaleEffect(1/scale)
    }
}
