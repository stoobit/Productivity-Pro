//
//  OverviewIcon.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 04.06.23.
//

import SwiftUI

struct OverviewRow: View {
    @Environment(ToolManager.self) var toolManager
    @Environment(SubviewManager.self) var subviewManager
    
    var contentObject: ContentObject
    var page: PPPageModel
    
    var body: some View {
        Button(action: { openPage() }) {
            ViewThatFits(in: .horizontal) {
                LargeView()
                
                ZStack {
                    Text("")
                        .overlay { PageOverview() }
                        .frame(width: 150, height: 150)
                    
                    Text(pageNumber())
                        .foregroundStyle(Color.secondary)
                        .font(.caption)
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .bottomTrailing
                        )
                }
            }
        }
        .frame(maxWidth: .infinity, minHeight: 200)
        .padding(.vertical)
    }
    
    @ViewBuilder func LargeView() -> some View {
        HStack {
            Text("")
                .overlay { PageOverview() }
                .frame(width: 150, height: 150)
                
            Spacer()
                
            VStack(alignment: .trailing) {
                Group {
                    Text(page.created, style: .date) +
                        Text(", ") +
                        Text(page.created, style: .time)
                }
                .multilineTextAlignment(.trailing)
                .foregroundStyle(Color.primary)
                .font(.body)
                .fontWeight(.semibold)
                    
                Spacer()
                    
                Text(pageNumber())
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
            }
            .padding(.leading, 30)
        }
    }
    
    @ViewBuilder func PageOverview() -> some View {
        ZStack {
            PageView(
                note: contentObject.note!,
                page: page,
                scale: .constant(1),
                offset: .constant(.zero),
                size: .zero,
                realrenderText: true
            )
            .scaleEffect(150 / getFrame().width)
            .frame(
                width: 150,
                height: (150 / getFrame().width) * getFrame().height
            )
            .clipShape(RoundedRectangle(cornerRadius: 9))
            .allowsHitTesting(false)

            RoundedRectangle(cornerRadius: 9)
                .stroke(Color.accentColor, lineWidth: 1.5)
                .frame(
                    width: 150,
                    height: (150 / getFrame().width) * getFrame().height
                )
        }
    }
}
