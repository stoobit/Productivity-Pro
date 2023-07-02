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
    
    let page: Page
    
    var body: some View {
        Button(action: { goToPage(page: page) }) {
            HStack {
                RoundedRectangle(cornerRadius: 9)
                    .foregroundStyle(.secondary)
                    .frame(width: 105, height: 148.5)
                    .frame(width: 148.5, height: 148.5)
                
                Spacer()
                
                OverviewRowInformation(
                    document: $document.document,
                    page: page
                )
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color.accentColor)
                    .font(.title.bold())
                    .padding(.trailing, 5)
            }
        }
        .padding(.vertical)
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(action: { toggleBookmark(page: page) }) {
                Image(systemName: bookmarkState())
            }
            .tint(.accentColor)
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button(action: {
                subviewManager.isDeletePageAlert = true
            }) {
                Image(systemName: "trash")
            }
            .tint(.red)
        }
        
    }
    
}
