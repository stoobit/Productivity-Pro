//
//  PPPageType.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 01.10.23.
//

import Foundation

enum PPPageType: Int, Codable {
    case none = 0
    
    case template = 1
    case pdf = 2
    case image = 3
    case mindmap = 4
}
