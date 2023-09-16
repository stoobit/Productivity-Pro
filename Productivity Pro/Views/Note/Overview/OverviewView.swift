//
//  OverviewView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 03.10.22.
//

import SwiftUI

struct OverviewView: View {
    
    @Environment(\.horizontalSizeClass) var hsc
    @Environment(\.undoManager) var undoManager
    @Environment(\.colorScheme) var cs
    
    @Binding var document: Document
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    @State var current: Page?
    @State var pageToDelete: Page!
    
    var body: some View {
    
        NavigationStack {
            ScrollViewReader { proxy in
                List {
                    ForEach($document.note.pages) { $page in
                        OverviewRow(
                            document: $document,
                            toolManager: toolManager,
                            subviewManager: subviewManager,
                            page: page
                        )
                        .moveDisabled(document.note.pages.count == 1)
                        .deleteDisabled(document.note.pages.count == 1)
                        .id(page.id)
                    }
                    .onMove(perform: move)
                    .onDelete(perform: delete)

                }
                .listStyle(.plain)
            }
            .navigationTitle("Overview")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.browser)
            .toolbarBackground(.visible, for: .tabBar)
            
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { subviewManager.overviewSheet.toggle()
                    }
                    .keyboardShortcut(.return, modifiers: [])
                }
            }
        }
    }
    
}
