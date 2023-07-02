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
    
    @State var selectedTab: OverviewListType = .all
    @State var pageToDelete: Page!
    
    var body: some View {
        let filteredPages: [Page] = document.document.note.pages.filter({
            $0.isBookmarked == true
        })
        
        NavigationStack {
            TabView(selection: $selectedTab) {
                
                Overview(document.document.note.pages)
                    .tag(OverviewListType.all)
                    .tabItem {
                        Label("All", systemImage: "list.bullet")
                    }
                
                Overview(filteredPages)
                    .tag(OverviewListType.bookmark)
                    .tabItem {
                        Label("Bookmarked", systemImage: "bookmark.fill")
                    }
                
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
    
    @ViewBuilder func Overview(_ pages: [Page]) -> some View {
        if pages.isEmpty {
            
            Image(systemName: "bookmark.slash.fill")
                .font(.system(size: 75))
                .foregroundColor(.secondary)
            
        } else {
            List(pages) { page in
                OverviewRow(
                    document: $document,
                    toolManager: toolManager,
                    subviewManager: subviewManager,
                    page: page
                )
                .listRowInsets(.none)
                .listRowSeparator(.hidden, edges: .all)
            }
            .listStyle(.plain)
        }
    }
    
}
