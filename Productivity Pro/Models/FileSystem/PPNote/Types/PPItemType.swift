//
//  PPItemType.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 01.10.23.
//

import Foundation

enum PPItemType: String, Codable {
    case shape = "shape"
    case media = "media"
    case textField = "textField"
    case chart = "chart"
    case table = "table"
    case mindmap = "mindmap"
    case immersiveObject = "immersiveObject"
}
