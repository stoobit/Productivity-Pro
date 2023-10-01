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
        self.type = type
        
        self.position = PPPosition(x: 0, y: 0)
        self.size = PPSize(width: 0, height: 0)
    }
    
    var type: PPItemType
    var isLocked: Bool = false
    
    var position: PPPosition
    var size: PPSize
    
    var shape: PPShapeModel?
    var media: PPMediaModel?
    var textField: PPTextFieldModel?
    var chart: PPChartModel?
    var table: PPTableModel?
    var mindmap: PPMindmapModel?
    var immersiveObject: PPImmersiveObjectModel?
}
