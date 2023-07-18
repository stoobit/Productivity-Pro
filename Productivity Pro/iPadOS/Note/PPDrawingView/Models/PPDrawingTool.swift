//
//  SwiftUIView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 18.07.23.
//

import SwiftUI

enum PPDrawingTool: String, Codable {
    case pen = "pen"
    case highlighter = "highlighter"
    
    case pointEraser = "pixelEraser"
    case strokeEraser = "strokeEraser"
}
