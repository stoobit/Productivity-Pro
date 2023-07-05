//
//  OverviewIcon.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 04.06.23.
//

import SwiftUI

struct OverviewRow: View {
    
    @Environment(\.undoManager) var undoManager
    
    @Binding var document: ProductivityProDocument
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    var page: Page
    
    var body: some View {
        Button(action: { openPage() }) {
                HStack {
                    
                    Text("")
                        .overlay { PageOverview() }
                        .frame(width: 150, height: 150)
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        
                        if header() != "" {
                            Text(header())
                                .font(.title3.bold())
                                .lineLimit(1)
                        }
                        
                        if let date = page.date {
                            Text(date, format: .dateTime)
                        } else {
                            Text("Date not available.")
                        }
                        
                        Spacer()
                        
                        Text(pageNumber())
                            .foregroundStyle(Color.secondary)
                            .font(.caption)
                    }
                    .padding(.leading, 30)
                    
                }
        }
        .frame(maxWidth: .infinity, minHeight: 200)
        .padding(.vertical)
        
    }
    
    @ViewBuilder func PageOverview() -> some View {
        ZStack {
            PageView(
                document: $document,
                page: .constant(page),
                offset: .constant(0),
                toolManager: ToolManager(),
                subviewManager: subviewManager,
                showShadow: true,
                isOverview: true,
                size: .zero
            )
            .scaleEffect(150 / getFrame().width)
            .frame(
                width: 150,
                height: (150 / getFrame().width) * getFrame().height
            )
            .clipShape(RoundedRectangle(cornerRadius: 9))
            .allowsHitTesting(false)
            
            RoundedRectangle(cornerRadius: 9)
                .stroke(Color.secondary, lineWidth: 2.0)
                .frame(
                    width: 150,
                    height: (150 / getFrame().width) * getFrame().height
                )
            
        }
    }
}
