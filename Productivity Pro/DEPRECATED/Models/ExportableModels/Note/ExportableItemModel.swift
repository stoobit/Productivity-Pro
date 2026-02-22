//
//  ExportableItemModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 04.10.23.
//

import Foundation

public struct ExportableItemModel: Codable {
    var id: UUID
    var isDeleted: Bool?
    
    var index: Int
    var type: PPItemType.RawValue
    
    var isLocked: Bool
    
    var x: Double
    var y: Double
    
    var width: Double
    var height: Double
    
    var shape: ExportableShapeModel?
    var media: ExportableMediaModel?
    var textField: ExportableTextFieldModel?
}
