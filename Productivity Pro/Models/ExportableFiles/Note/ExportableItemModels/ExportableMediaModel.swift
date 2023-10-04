//
//  ExportableMediaModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 04.10.23.
//

import Foundation

struct ExportableMediaModel: Codable {
    var media: Data
    
    var stroke: Bool
    var strokeColor: Data
    var strokeWidth: CGFloat
    var strokeStyle: PPStrokeType
    
    var shadow: Bool
    var shadowColor: Data
    
    var cornerRadius: CGFloat
    var rotation: CGFloat
}
