//
//  PPDrawingBar.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.07.23.
//

import SwiftUI

struct PPDrawingBar: View {
    
    @StateObject var drawingModel: PPDrawingModel
    
    var body: some View {
        HStack {
            Group {
                PPToolButton(
                    icon: "pencil.line",
                    isTinted: drawingModel.selectedTool == .pen
                ) {
                    drawingModel.selectedTool = .pen
                }
                .padding(.trailing, 2.5)
                
                PPToolButton(
                    icon: "highlighter",
                    isTinted: drawingModel.selectedTool == .highlighter
                ) {
                    drawingModel.selectedTool = .highlighter
                }
                .padding(.horizontal, 2.5)
                
                PPToolButton(
                    icon: "wand.and.rays",
                    isTinted: drawingModel.selectedTool == .magicwand
                ) {
                    drawingModel.selectedTool = .magicwand
                }
                .padding(.horizontal, 2.5)
                
                PPToolButton(
                    icon: "eraser",
                    isTinted: drawingModel.selectedTool == .eraser
                ) {
                    drawingModel.selectedTool = .eraser
                }
                .padding(.horizontal, 2.5)
                
                PPToolButton(
                    icon: "lasso",
                    isTinted: drawingModel.selectedTool == .lasso
                ) {
                    drawingModel.selectedTool = .lasso
                }
                .padding(.leading, 2.5)
            }
            
            Divider()
                .frame(height: 35)
                .padding(.horizontal, 5)
            
            Group {
                PPColorButton(
                    color: .black,
                    selectedColor: $drawingModel.selectedColor
                )
                .padding(.horizontal, 2.5)
                
                PPColorButton(
                    color: .accentColor,
                    selectedColor: $drawingModel.selectedColor
                )
                .padding(.horizontal, 2.5)
                
                PPColorButton(
                    color: .pink,
                    selectedColor: $drawingModel.selectedColor
                )
                .padding(.leading, 2.5)
            }
            
            Divider()
                .frame(height: 35)
                .padding(.horizontal, 5)

        }
        .padding(10)
        .background(.ultraThickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 19))
    }
}

struct DrawingBar_Preview: PreviewProvider {
    static var previews: some View {
        PPDrawingBar(drawingModel: PPDrawingModel())
    }
}

