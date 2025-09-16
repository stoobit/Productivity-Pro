//
//  IndicatorText.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 23.10.22.
//

import SwiftUI

struct IndicatorText: View {
    @Environment(ToolManager.self) var toolManager
    var pages: [PPPageModel]
    
    init(contentObject: ContentObject?) {
        pages = contentObject?.note?.pages ?? []
    }
    
    var body: some View {
        let total = pages.count
        let number = (toolManager.activePage?.index ?? 0) + 1
        
        Text("\(number) von \(total)")
            .lineLimit(1)
            .fontWeight(.semibold)
            .font(.caption)
    }
    
    func page() -> String {
        let total = pages.count
        let number = (toolManager.activePage?.index ?? 0) + 1
        
        return "\(number) von \(total)"
    }
}
