//
//  ExportablePageModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 04.10.23.
//

import Foundation

public struct ExportablePageModel: Codable {
    var id: UUID
    
    var type: PPPageType.RawValue
    var index: Int
    
    var title: String
    var created: Date
    var isBookmarked: Bool
    
    var template: String
    var color: String
    var isPortrait: Bool
    var media: Data?
    
    var pkCanvas: Data
    
    var items: [ExportableItemModel] = []
}
