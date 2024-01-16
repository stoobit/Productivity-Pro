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
        
        ZStack {
            UnevenRoundedRectangle(
                topLeadingRadius: 0,
                bottomLeadingRadius: 8,
                bottomTrailingRadius: 8,
                topTrailingRadius: 0,
                style: .circular
            )
            .foregroundStyle(Color.secondary)
            .frame(width: 60, height: 30)
            
            Text("\(number) von \(total)")
                .fontWeight(.semibold)
                .font(.caption)
                .foregroundStyle(Color.white)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topTrailing
        )
        .padding(.trailing, 10)
    }
}
