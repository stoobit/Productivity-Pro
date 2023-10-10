//
//  PPItemProtocol.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.09.23.
//

import Foundation
import SwiftData

@Model final class PPItemModel: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
   
    @Relationship(inverse: \PPPageModel.items)
    var page: PPPageModel?
    
    init(type: PPItemType) {
        self.type = type.rawValue
    }
    
    var type: PPItemType.RawValue
    var isLocked: Bool = false
    
    var x: Double = 0
    var y: Double = 0
    
    var width: Double = 0
    var height: Double = 0
    
    var shape: PPShapeModel?
    var media: PPMediaModel?
    var textField: PPTextFieldModel?
    
    var link: PPLinkModel?
    var chart: PPChartModel?
    var table: PPTableModel?
    var mindmap: PPMindmapModel?
    var immersiveObject: PPImmersiveObjectModel?
}
