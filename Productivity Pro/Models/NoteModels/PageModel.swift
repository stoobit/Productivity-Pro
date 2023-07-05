//
//  PageModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.22.
//

import Foundation
import PDFKit

struct Page: Codable, Identifiable, Hashable {
    
    var id: UUID = UUID()
    var type: PageType = .template
    
    var date: Date? = Date()
    
    var backgroundMedia: Data?
    var header: String?
    
    var backgroundColor: String
    var backgroundTemplate: String
    var isPortrait: Bool
    
    var isBookmarked: Bool = false
    
    var canvas: Data = Data()
    var items: [ItemModel] = []
    
}

enum PageType: Codable {
    case template
    case pdf
    case image
}
