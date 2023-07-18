//
//  PPDrawingModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 18.07.23.
//

import SwiftUI

class PPDrawingModel: ObservableObject {
    
    @Published var lines: [PPLine] = []
    @Published var selectedLines: [PPLine] = []
    
    @Published var selectedColor: Color = .black
    @Published var lineWidth: CGFloat = 5
    @Published var selectedTool: PPDrawingTool = .pen
    
}
