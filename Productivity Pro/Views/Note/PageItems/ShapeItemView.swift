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
                            cornerRadius: shape.cornerRadius * toolManager.zoomScale,
                            style: .circular
                        ),
                        shape: shape
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
                    .modifier(CornerModifier(
                        editItem: editItem,
                        toolManager: toolManager,
                        item: $item
                    ))
            }
            
            if shape.showStroke {
                stroke
                    .stroke(
                        Color(codable: shape.strokeColor)!,
                        lineWidth: shape.strokeWidth * toolManager.zoomScale
                    )
                    .frame(
                        width: (editItem.size.width + item.shape!.strokeWidth) * toolManager.zoomScale,
                        height: (editItem.size.height + item.shape!.strokeWidth) * toolManager.zoomScale
                    )
                    .contentShape(stroke)
            }
            
        }
        
    }
}

struct CornerModifier: ViewModifier {
    
    @StateObject var editItem: EditItemModel
    @StateObject var toolManager: ToolManager
    
    @Binding var item: ItemModel
    
    func body(content: Content) -> some View {
        
        if item.shape!.showStroke {
            content
                .frame(
                    width: (editItem.size.width + item.shape!.strokeWidth) * toolManager.zoomScale,
                    height: (editItem.size.height + item.shape!.strokeWidth) * toolManager.zoomScale
                )
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: item.shape!.cornerRadius * toolManager.zoomScale,
                        style: .circular
                    )
                )
            
            
        } else {
            content
        }
    }
}
