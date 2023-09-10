//
//  PPDrawingModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 18.07.23.
//

import SwiftUI

class PPDrawingModel: ObservableObject {
    
    @Published var selectedLines: [PPLine] = []
    
    @Published var selectedColor: Color = .red
    @Published var selectedWidth: Double = 5
    
    @Published var selectedTool: PPDrawingTool = .pen
    @Published var eraserType: PPEraserType = .point
    
    @Published var objectRecognitionTool: PPRecognitionTool = .none
    
}
