//
//  ShapeItemView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 16.02.23.
//

import SwiftUI

struct ShapeItemView: View {
    
    @Bindable var item: PPItemModel
    
    @Binding var editItem: EditItemModel
    @Binding var scale: CGFloat
    
    var body: some View {
        Group {
            if let shape = item.shape {
                if shape.type == PPShapeType.rectangle.rawValue {
                    
                    
                    
                } else if shape.type == PPShapeType.circle.rawValue {
                    
                    StandardShapeView(shape: Ellipse(), model: shape)
                    
                } else if shape.type == PPShapeType.triangle.rawValue {
                    
                    StandardShapeView(shape: Triangle(), model: shape)
                    
                } else if shape.type == PPShapeType.hexagon.rawValue {
                    
                    StandardShapeView(shape: Hexagon(), model: shape)
                }
            }
        }
    }
    
    @ViewBuilder func StandardShapeView(shape: some Shape, model: PPShapeModel) -> some View {
        ZStack {
            if model.fill {
                shape
                    .fill(Color(data: model.fillColor))
                    .frame(
                        width: editItem.size.width * scale,
                        height: editItem.size.height * scale
                    )
            }

            if model.stroke {
                shape
                    .stroke(
                        Color(data: model.strokeColor),
                        lineWidth: model.strokeWidth * scale
                    )
                    .frame(
                        width: (editItem.size.width + model.strokeWidth) * scale,
                        height: (editItem.size.height + model.strokeWidth) * scale
                    )
            }
        }
    }
    
    @ViewBuilder func RoundedShapeView(model: PPShapeModel) -> some View {
        ZStack {
            if model.fill {
                Rectangle()
                    .fill(Color(data: model.fillColor))
                    .frame(
                        width: editItem.size.width * scale,
                        height: editItem.size.height * scale
                    )
            }

            if model.stroke {
                RoundedRectangle(cornerRadius: model.cornerRadius)
                    .stroke(
                        Color(data: model.strokeColor),
                        lineWidth: model.strokeWidth * scale
                    )
                    .frame(
                        width: (editItem.size.width + model.strokeWidth) * scale,
                        height: (editItem.size.height + model.strokeWidth) * scale
                    )
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: model.cornerRadius))
    }
    
}

struct CornerModifier: ViewModifier {
    
    var item: PPItemModel
    
    @Binding var editItem: EditItemModel
    @Binding var scale: CGFloat
    
    func body(content: Content) -> some View {
        
        if item.shape!.stroke {
            content
                .frame(
                    width: (editItem.size.width + item.shape!.strokeWidth) * scale,
                    height: (editItem.size.height + item.shape!.strokeWidth) * scale
                )
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: item.shape!.cornerRadius * scale,
                        style: .circular
                    )
                )
        } else {
            content
        }
    }
}
