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
                List {
                    ForEach($document.document.note.pages) { $page in
                        OverviewRow(
                            document: $document,
                            toolManager: toolManager,
                            subviewManager: subviewManager,
                            page: page
                        )
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            Button(action: {
                                
                            }) {
                                Image(systemName: page.isBookmarked ? "bookmark.slash" : "bookmark")
                            }
                            .tint(Color.accentColor)
                        }
                        .deleteDisabled(
                            document.document.note.pages.count < 2
                        )
                    }
                    .onMove(perform: move)
                    .onDelete(perform: delete)
                }
                .listStyle(.plain)
                .tag(OverviewListType.all)
                .tabItem {
                    Label("All", systemImage: "list.bullet")
                }
                
                List {
                    ForEach(filteredPages) { page in
                        OverviewRow(
                            document: $document,
                            toolManager: toolManager,
                            subviewManager: subviewManager,
                            page: page
                        )
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            Button(action: {
                               
                            }) {
                                Image(systemName: page.isBookmarked ? "bookmark.slash" : "bookmark")
                            }
                            .tint(Color.accentColor)
                        }
                    }
                }
                .listStyle(.plain)
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
    
}
