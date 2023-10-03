//
//  ExportableItemModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 04.10.23.
//

import Foundation

struct ExportableItemModel: Codable {
    var id: UUID
    
    var type: PPItemType
    var isLocked: Bool = false
    
    var position: PPPosition = PPPosition(x: 0, y: 0)
    var size: PPSize = PPSize(width: 0, height: 0)
    
    var shape: ExportableShapeModel?
    var media: ExportableMediaModel?
    var textField: ExportableTextFieldModel?
    
}
