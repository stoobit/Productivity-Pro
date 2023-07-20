//
//  PPDrawingBar.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.07.23.
//

import SwiftUI

struct PPDrawingBar: View {
    
    @StateObject var drawingModel: PPDrawingModel
    
    @AppStorage("drawingcolor1") var firstColor: Color = Color.black
    @AppStorage("drawingcolor2") var secondColor: Color = Color.red
    @AppStorage("drawingcolor3") var thirdColor: Color = Color.blue
    
    var hsc: UserInterfaceSizeClass?
    var size: CGSize
    
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
            
            PPToolButton(
                icon: "wand.and.rays",
                isTinted: drawingModel.objectDetectionEnabled == true
            ) {
                drawingModel.objectDetectionEnabled.toggle()
            }
            .padding(.horizontal, 2.5)
            
            Divider()
                .frame(height: 35)
                .padding(.horizontal, 5)
            
            Group {
                PPColorButton(
                    color: $firstColor,
                    selectedColor: $drawingModel.selectedColor,
                    hsc: hsc,
                    size: size
                )
                .padding(.horizontal, 2.5)
                
                PPColorButton(
                    color: $secondColor,
                    selectedColor: $drawingModel.selectedColor,
                    hsc: hsc,
                    size: size
                )
                .padding(.horizontal, 2.5)
                
                PPColorButton(
                    color: $thirdColor,
                    selectedColor: $drawingModel.selectedColor,
                    hsc: hsc,
                    size: size
                )
                .padding(.leading, 2.5)
            }
            
            Divider()
                .frame(height: 35)
                .padding(.horizontal, 5)
            
            Group {
                PPSizeButton(
                    width: .constant(15),
                    selectedWidth: $drawingModel.selectedWidth
                )
                .padding(.horizontal, 2.5)
                
                PPSizeButton(
                    width: .constant(10),
                    selectedWidth: $drawingModel.selectedWidth
                )
                .padding(.horizontal, 2.5)
                
                PPSizeButton(
                    width: .constant(5),
                    selectedWidth: $drawingModel.selectedWidth
                )
                .padding(.leading, 2.5)
            }
            
            Divider()
                .frame(height: 35)
                .padding(.horizontal, 5)
            
            PPMenuView()
                .padding(.horizontal, 2.5)

        }
        .padding(10)
        .background(.ultraThickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 19))
    }
}
