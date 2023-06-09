//
//  OverviewView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 03.10.22.
//

import SwiftUI

struct OverviewView: View {
    
    @Environment(\.undoManager) var undoManager
    @Environment(\.horizontalSizeClass) var hsc
    @Environment(\.colorScheme) var cs
    
    @Binding var document: ProductivityProDocument
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    @State var isDeleteAlert: Bool = false
    @State var current: Page?
    
    @State var selectedTab: OverviewListType = .all
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                TabView(selection: $selectedTab) {
                    
                    Overview(type: .all, size: proxy.size)
                        .tag(OverviewListType.all)
                        .tabItem {
                            Label("All", systemImage: "list.bullet")
                        }
                    
                    Overview(type: .bookmark, size: proxy.size)
                        .tag(OverviewListType.bookmark)
                        .tabItem {
                            Label("Bookmarked", systemImage: "bookmark.fill")
                        }
                    
                }
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") { subviewManager.overviewSheet.toggle()
                        }
                        .keyboardShortcut(.return, modifiers: [])
                    }
                }
                
            }
            .navigationTitle("Overview")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.browser)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
    
    @ViewBuilder func Overview(type: OverviewListType, size: CGSize) -> some View {
        
        let columns: [GridItem] = Array(repeating: GridItem(), count: 3)
        let filteredPages: [Page] = document.document.note.pages.filter( { $0.isBookmarked == true })
        
        if filteredPages.isEmpty && type == .bookmark {
            Image(systemName: "bookmark.slash.fill")
                .font(.system(size: 75))
                .foregroundColor(.secondary)
        } else {
            ScrollView(showsIndicators: false) {
                ScrollViewReader { reader in
                    LazyVStack {
                        if type == .all {
                            LazyVGrid(columns: columns) {
                                ForEach($document.document.note.pages) { $page in
                                    
                                    let index = document.document.note.pages.firstIndex(of: page) ?? 0
                                    
                                    VStack {
                                        Button(action: { goToPage(page: page) }) {
                                            OverviewIcon(
                                                document: $document,
                                                page: page,
                                                toolManager: toolManager,
                                                subviewManager: subviewManager,
                                                size: size
                                            )
                                        }
                                        
                                        HStack {
                                            Button(action: { toggleBookmark(page: page) }) {
                                                Image(systemName: page.isBookmarked ? "bookmark.fill" : "bookmark")
                                            }
                                            .foregroundColor(.red)
                                            
                                            Spacer()
                                            
                                            OverviewPageIndicator(document: document, index: index) {
                                                delete(page)
                                            }
                                        }
                                        .padding(.horizontal, 10)
                                        .frame(width: size.width / 4)
                                        .padding(.top, 10)
                                        .padding(.bottom, 3)
                                        
                                    }
                                    .padding()
                                    .modifier(
                                        DragAndDropPage(
                                            document: $document,
                                            page: page,
                                            type: type,
                                            current: $current,
                                            toolManager: toolManager
                                        )
                                    )
                                    .id(document.document.note.pages.firstIndex(of: page))
                                    
                                }
                                .onAppear { reader.scrollTo(toolManager.selectedPage) }
                            }
                        } else {
                            LazyVGrid(columns: columns) {
                                ForEach(filteredPages) { page in
                                    
                                    let index = document.document.note.pages.firstIndex(of: page) ?? 0
                                    
                                    VStack {
                                        Button(action: { goToPage(page: page) }) {
                                            OverviewIcon(
                                                document: $document,
                                                page: page,
                                                toolManager: toolManager,
                                                subviewManager: subviewManager,
                                                size: size
                                            )
                                        }
                                        
                                        HStack {
                                            Button(action: { toggleBookmark(page: page) }) {
                                                Image(systemName: page.isBookmarked ? "bookmark.fill" : "bookmark")
                                            }
                                            .foregroundColor(.red)
                                            
                                            Spacer()
                                            
                                            OverviewPageIndicator(document: document, index: index) {
                                                delete(page)
                                            }
                                        }
                                        .padding(.horizontal, 10)
                                        .frame(width: size.width / 4)
                                        .padding(.top, 10)
                                        .padding(.bottom, 3)
                                        
                                    }
                                    .padding()
                                    .id(document.document.note.pages.firstIndex(of: page))
                                    
                                }
                                .onAppear { reader.scrollTo(toolManager.selectedPage) }
                            }
                            .animation(.default, value: filteredPages.count)
                        }
                    }
                }
                
            }
        }
    }
    
}
