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
    
    @Binding var document: ProductivityProDocument
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    @State var isDeleteAlert: Bool = false
    @State var current: Page?
    
    @State var pageToDelete: Page!
    
    var body: some View {
    
        NavigationStack {
            List {
                ForEach($document.document.note.pages) { $page in
                    OverviewRow(
                        document: $document,
                        toolManager: toolManager,
                        subviewManager: subviewManager,
                        page: page
                    )
                    .moveDisabled(document.document.note.pages.count == 1)
                }
                .onMove(perform: move)
                .onDelete(perform: delete)
            }
            .listStyle(.plain)
            .tabItem {
                Label("All", systemImage: "list.bullet")
            }
            .navigationTitle("Overview")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.browser)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { subviewManager.overviewSheet.toggle()
                    }
                    .keyboardShortcut(.return, modifiers: [])
                }
            }
            .alert(
                "Delete this Page",
                isPresented: $subviewManager.isDeletePageAlert,
                actions: {
                    Button("Delete Page", role: .destructive) {
                        delete(pageToDelete)
                    }
                    
                    Button("Cancel", role: .cancel) { subviewManager.isDeletePageAlert.toggle()
                    }
                }) {
                    Text("You cannot undo this action.")
                }
        }
    }
    
}
