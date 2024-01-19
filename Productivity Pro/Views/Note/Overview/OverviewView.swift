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
//    @Environment(\.colorScheme) var cs
    
    @Environment(ToolManager.self) var toolManager
    @Environment(SubviewManager.self) var subviewManager
    
    @Bindable var contentObject: ContentObject
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                List {
                    ForEach(contentObject.note?.pages ?? []) { page in
                        OverviewRow(contentObject: contentObject, page: page)
                        .moveDisabled(contentObject.note?.pages?.count == 1)
                        .deleteDisabled(contentObject.note?.pages?.count == 1)
                        .id(page.id)
                    }
                    .onMove(perform: move)
                    .onDelete(perform: delete)

                }
                .listStyle(.plain)
            }
            .navigationTitle("Übersicht")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.browser)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Fertig") { 
                        subviewManager.overview.toggle()
                    }
                    .keyboardShortcut(.return, modifiers: [])
                }
            }
        }
    }
    
}
