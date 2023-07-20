//
//  PPDrawingBar.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.07.23.
//

import SwiftUI

struct PPDrawingBar: View {
    
    @StateObject var drawingModel: PPDrawingModel
    @StateObject var toolManager: ToolManager
    
    @AppStorage("colorSelection") var selectedColor: Int = 0
    
    @AppStorage("drawingcolor1") var firstColor: Color = Color.black
    @AppStorage("drawingcolor2") var secondColor: Color = Color.red
    @AppStorage("drawingcolor3") var thirdColor: Color = Color.blue
    
    var hsc: UserInterfaceSizeClass?
    var size: CGSize
    
    var body: some View {
        ViewThatFits(in: .horizontal) {
            DrawingBar(0)
                .padding(10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                DrawingBar(10)
            }
            .padding(.vertical, 10)
        }
        .background(.ultraThickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 19))
        .padding(.horizontal, 10)
        .onAppear {
            switch selectedColor {
            case 0: drawingModel.selectedColor = firstColor
            case 1: drawingModel.selectedColor = secondColor
            case 2: drawingModel.selectedColor = thirdColor
            default:
                break
            }
        }
    }
    
    @ViewBuilder func DrawingBar(_ outerPadding: CGFloat) -> some View {
        HStack {
            Group {
                PPToolButton(
                    icon: "pencil.line",
                    isTinted: drawingModel.selectedTool == .pen
                ) {
                    drawingModel.selectedTool = .pen
                }
                .padding(.trailing, 2.5)
                .padding(.leading, outerPadding)
                
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
                .padding(.horizontal, 2.5)
            }
            
            Divider()
                .frame(height: 35)
                .padding(.horizontal, 2.5)
            
            Group {
                PPToolButton(
                    icon: "wand.and.rays",
                    isTinted: drawingModel.objectRecognitionTool == .objectRecognition
                ) {
                    if drawingModel.objectRecognitionTool == .objectRecognition {
                        drawingModel.objectRecognitionTool = .none
                    } else {
                        drawingModel.objectRecognitionTool = .objectRecognition
                    }
                }
                .padding(.horizontal, 2.5)
                
                PPToolButton(
                    icon: "ruler",
                    isTinted: drawingModel.objectRecognitionTool == .ruler
                ) {
                    if drawingModel.objectRecognitionTool == .ruler {
                        drawingModel.objectRecognitionTool = .none
                    } else {
                        drawingModel.objectRecognitionTool = .ruler
                    }
                }
                .padding(.horizontal, 2.5)
            }
            
            Divider()
                .frame(height: 35)
                .padding(.horizontal, 2.5)
            
            Group {
                PPColorButton(
                    color: $firstColor,
                    selectedColor: $drawingModel.selectedColor,
                    selectedValue: $selectedColor,
                    value: 0,
                    hsc: hsc,
                    size: size
                )
                .padding(.horizontal, 2.5)
                
                PPColorButton(
                    color: $secondColor,
                    selectedColor: $drawingModel.selectedColor,
                    selectedValue: $selectedColor,
                    value: 1,
                    hsc: hsc,
                    size: size
                )
                .padding(.horizontal, 2.5)
                
                PPColorButton(
                    color: $thirdColor,
                    selectedColor: $drawingModel.selectedColor,
                    selectedValue: $selectedColor,
                    value: 2,
                    hsc: hsc,
                    size: size
                )
                .padding(.horizontal, 2.5)
            }
            
            Divider()
                .frame(height: 35)
                .padding(.horizontal, 2.5)
            
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
            }
            
            Divider()
                .frame(height: 35)
                .padding(.horizontal, 5)
            
            PPMenuView(toolManager: toolManager)
                .padding(.leading, 2.5)
                .padding(.trailing, outerPadding)

        }
    }
}
