//
//  MediaModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.02.23.
//

import SwiftUI

struct MediaModel: Codable, Hashable {
    
    var media: Data
    
    var showStroke: Bool = false
    var strokeColor: Data = Color.accentColor.data()
    var strokeWidth: Double = 5
    var strokeStyle: BorderStrokeStyle = .line
    
    var cornerRadius: Double = 0
    
}
