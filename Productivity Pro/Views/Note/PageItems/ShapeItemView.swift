//
//  ShapeItemView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 16.02.23.
//

import SwiftUI

struct ShapeItemView: View {
    
    @Binding var item: ItemModel
    @StateObject var toolManager: ToolManager
    @StateObject var editItem: EditItemModel
    
    var body: some View {
        Group {
            if let shape = item.shape {
                if shape.type == .rectangle {
                    
                    ShapeTypeView(
                        form: Rectangle(),
                        stroke: RoundedRectangle(
                            cornerRadius: shape.cornerRadius * toolManager.zoomScale
                        ),
                        shape: shape
                    )
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: shape.cornerRadius * toolManager.zoomScale
                        )
                    )
                    
                } else if shape.type == .circle {
                    ShapeTypeView(form: Ellipse(), stroke: Ellipse(), shape: shape)
                } else if shape.type == .triangle {
                    ShapeTypeView(form: Triangle(), stroke: Triangle(), shape: shape)
                } else if shape.type == .hexagon {
                    ShapeTypeView(form: Hexagon(), stroke: Hexagon(), shape: shape)
                }
            }
        }
    }
    
    @ViewBuilder func ShapeTypeView(
        form: some Shape, stroke: some Shape, shape: ShapeModel
    ) -> some View {
        ZStack {
            
            if shape.showFill {
                form
                    .fill(Color(codable: shape.fillColor)!)
                    .frame(
                        width: editItem.size.width * toolManager.zoomScale,
                        height: editItem.size.height * toolManager.zoomScale
                    )
            }
            
            if shape.showStroke {
                stroke
                    .stroke(
                        Color(codable: shape.strokeColor)!,
                        lineWidth: shape.strokeWidth * toolManager.zoomScale
                    )
                    .contentShape(stroke)
                    .frame(
                        width: (editItem.size.width + item.shape!.strokeWidth) * toolManager.zoomScale,
                        height: (editItem.size.height + item.shape!.strokeWidth) * toolManager.zoomScale,
                        alignment: .topLeading
                    )
            }
            
        }
        
    }
}
