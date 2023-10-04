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
    var isLocked: Bool
    
    var position: PPPosition
    var size: PPSize
    
    var shape: ExportableShapeModel?
    var media: ExportableMediaModel?
    var textField: ExportableTextFieldModel?
}
