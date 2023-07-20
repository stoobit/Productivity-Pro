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
    @Published var selectedWidth: CGFloat = 5
    
    @Published var selectedTool: PPDrawingTool = .pen
    @Published var eraserType: PPEraserType = .point
    
    @Published var objectDetectionEnabled: Bool = false
    
}
