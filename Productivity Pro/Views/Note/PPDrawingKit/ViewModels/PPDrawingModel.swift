//
//  PPDrawingModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 18.07.23.
//

import SwiftUI

@Observable class PPDrawingModel {
    
    var selectedLines: [PPLine] = []
    
    var selectedColor: Color = .red
    var selectedWidth: Double = 5
    
    var selectedTool: PPDrawingTool = .pen
    var eraserType: PPEraserType = .point
    
    var objectRecognitionTool: PPRecognitionTool = .none
    
}
