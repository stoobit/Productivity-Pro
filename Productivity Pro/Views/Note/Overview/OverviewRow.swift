//
//  OverviewIcon.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 04.06.23.
//

import SwiftUI
import PDFKit

struct OverviewRow: View {
    
    @Environment(\.undoManager) var undoManager
    
    @Binding var document: ProductivityProDocument
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    var page: Page
    
    var body: some View {
        Button(action: { openPage() }) {
            HStack {
                VStack(alignment: .leading) {
                    Text(header().0)
                        .font(.title.bold())
                        .lineLimit(1)
                    
                    Text(header().1)
                        .lineLimit(1)
                    Spacer()
                    
                    if let date = page.date {
                        Text(date, format: .dateTime)
                    } else {
                        Text("Date not available.")
                    }
                    
                    Text(pageNumber())
                        .foregroundStyle(Color.secondary)
                        .font(.caption)
                }
                .padding(.trailing)
                
                Spacer()
                
                Text("")
                    .overlay { PageOverview() }
                    .frame(width: 150, height: 150)
                
            }
        }
        .frame(maxWidth: .infinity, minHeight: 200)
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
    
    func pageNumber() -> String {
        let index = document.document.note.pages.firstIndex(of: page) ?? -1
        return "Page \(index + 1)"
    }
    
    func header() -> (String, String) {
        var text: String = ""
        
        if page.type == .pdf {
            if let document = PDFDocument(data: page.backgroundMedia!) {
                text = document.page(at: 0)?.string ?? ""
            }
            
        } else {
            
        }
        
        let title = text.components(separatedBy: .newlines).first ?? ""
        var subtitle: String = ""
        
        if text.components(separatedBy: .newlines).indices.contains(1) {
            subtitle = text.components(separatedBy: .newlines)[1]
        }
        
        return (title, subtitle)
    }

}
