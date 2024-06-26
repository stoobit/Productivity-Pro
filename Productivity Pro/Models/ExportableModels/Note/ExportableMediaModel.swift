//
//  ExportableMediaModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 04.10.23.
//

import Foundation

public struct ExportableMediaModel: Codable {
    var media: Data
    
    var stroke: Bool
    var strokeColor: Data
    var strokeWidth: Double
    var strokeStyle: PPStrokeType.RawValue
    
    var shadow: Bool
    var shadowColor: Data
    
    var cornerRadius: Double
    var rotation: Double
}
