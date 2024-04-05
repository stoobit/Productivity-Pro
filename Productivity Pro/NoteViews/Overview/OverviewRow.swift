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
    @Environment(PagingViewModel.self) var pvModel
    
    var contentObject: ContentObject
    @Bindable var page: PPPageModel
    
    var update: () -> Void
    
    var body: some View {
        ViewThatFits(in: .horizontal) {
            LargeView()
            
            ZStack {
                PreviewView()
                
                Text(compactPageNumber())
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .bottomTrailing
                    )
            }
        }
        .frame(maxWidth: .infinity, minHeight: page.isPortrait ? 200 : 100)
        .padding(.vertical)
        .contentShape(Rectangle())
        .onTapGesture {
            openPage()
        }
    }
    
    @ViewBuilder func PreviewView() -> some View {
        Text("")
            .overlay {
                PageOverview()
                
                Image(systemName: page.isBookmarked ? "bookmark.fill" : "bookmark")
                    .contentTransition(.symbolEffect(.replace))
                    .foregroundStyle(Color.red)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .bottomTrailing
                    )
                    .padding(7)
                    .onTapGesture {
                        withAnimation(.bouncy) {
                            page.isBookmarked.toggle()
                            update()
                        }
                    }
            }
            .frame(width: 150, height: 150)
    }
    
    @ViewBuilder func LargeView() -> some View {
        HStack {
            PreviewView()
                
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
                scale: .constant(0.01),
                offset: .constant(.zero),
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
