//
//  DocumentItem.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.02.23.
//

import SwiftUI

struct ItemModel: Codable, Identifiable, Hashable, Equatable {
    var id: UUID = UUID()
    
    var width: Double = 0
    var height: Double = 0
    
    var x: Double = 0
    var y: Double = 0
    
    var rotation: Double = 0
    
    var type: ItemType = .none
    
    var shape: ShapeModel?
    var textField: TextFieldModel?
    var media: MediaModel?

}

enum ItemType: Codable {
    case shape
    case textField
    case media
    case none
}
