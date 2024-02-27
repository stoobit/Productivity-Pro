//
//  ShapeItemView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 16.02.23.
//

import SwiftUI

struct ShapeItemView: View {
    @Bindable var item: PPItemModel
    @Bindable var vuModel: ShapeVUModel
    
    @Binding var scale: CGFloat
    
    var body: some View {
        if let shape = item.shape {
            Group {
                if shape.type == PPShapeType.rectangle.rawValue {
                    ShapeView(
                        shape: RoundedRectangle(
                            cornerRadius: shape.cornerRadius * scale,
                            style: .circular
                        ),
                        model: shape
                    )
                    
                } else if shape.type == PPShapeType.circle.rawValue {
                    ShapeView(shape: Ellipse(), model: shape)
                    
                } else if shape.type == PPShapeType.triangle.rawValue {
                    ShapeView(shape: Triangle(), model: shape)
                    
                } else if shape.type == PPShapeType.hexagon.rawValue {
                    ShapeView(shape: Hexagon(), model: shape)
                }
            }
            .rotationEffect(Angle(degrees: shape.rotation))
        }
    }
    
    @ViewBuilder func ShapeView(shape: some Shape, model: PPShapeModel) -> some View {
        ZStack {
            if model.fill {
                if model.stroke {
                    shape
                        .fill(Color(data: model.fillColor))
                        .frame(
                            width: (vuModel.size.width + model.strokeWidth / 2) * scale,
                            height: (vuModel.size.height + model.strokeWidth / 2) * scale
                        )
                        .contentShape(shape)
                    
                } else {
                    shape
                        .fill(Color(data: model.fillColor))
                        .frame(
                            width: vuModel.size.width * scale,
                            height: vuModel.size.height * scale
                        )
                        .contentShape(shape)
                }
            }
            
            if model.stroke {
                shape
                    .stroke(
                        Color(data: model.strokeColor),
                        lineWidth: model.strokeWidth * scale
                    )
                    .frame(
                        width: (vuModel.size.width + model.strokeWidth) * scale,
                        height: (vuModel.size.height + model.strokeWidth) * scale
                    )
                    .contentShape(shape)
            }
        }
    }
}
