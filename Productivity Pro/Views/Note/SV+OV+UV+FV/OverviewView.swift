//
//  OverviewView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 03.10.22.
//

import SwiftUI

struct OverviewView: View {
    
    @Environment(\.horizontalSizeClass) var hsc
    @Environment(\.colorScheme) var cs
    
    @Binding var document: Productivity_ProDocument
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    @State var isDeleteAlert: Bool = false
    @State var renderedPages: [OverviewModel] = []
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
                        Button("Done") { subviewManager.overviewSheet.toggle() }
                    }
                    
#if targetEnvironment(macCatalyst)
                    ToolbarItemGroup(placement: .bottomBar) {
                        HStack {
                            Button(action: {
                                selectedTab = .all
                            }) {
                                Label("All", systemImage: "list.bullet")
                                    .foregroundColor(
                                        selectedTab == .all ? .accentColor : .secondary
                                    )
                            }
                            .frame(width: proxy.size.width / 2)
                            
                            Button(action: {
                                selectedTab = .bookmark
                            }) {
                                Label("Bookmarked", systemImage: "bookmark.fill")
                                    .foregroundColor(
                                        selectedTab == .bookmark ? .accentColor : .secondary
                                    )
                            }
                            .frame(width: proxy.size.width / 2)
                        }
                    }
#endif
                }
                
            }
            .navigationTitle("Overview")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.browser)
#if !targetEnvironment(macCatalyst)
            .toolbarBackground(.visible, for: .tabBar)
#else
            .tabViewStyle(.page(indexDisplayMode: .never))
#endif
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
                                            
                                            Text("\(index + 1)")
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
                                            
                                            Text("\(index + 1)")
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
    
    func goToPage(page: Page) {
        withAnimation {
            toolManager.selectedTab = page.id
            subviewManager.overviewSheet.toggle()
        }
    }
    
    func toggleBookmark(page: Page) {
        document.document.note.pages[
            document.document.note.pages.firstIndex(of: page)!
        ].isBookmarked.toggle()
    }
    
}

struct DragAndDropPage: ViewModifier {
    
    @Binding var document: Productivity_ProDocument
    
    let page: Page
    let type: OverviewListType
    
    @Binding var current: Page?
    @StateObject var toolManager: ToolManager
    
    func body(content: Content) -> some View {
        if type == .all {
            content
                .onDrag({
                    current = page
                    return NSItemProvider(contentsOf: URL(string: "\(page.id)")!)!
                })
                .onDrop(of: [.url],
                        delegate:
                            DragRelocateDelegate(
                                item: page,
                                listData: $document.document.note.pages,
                                current: $current, toolManager: toolManager
                            )
                )
            
        } else {
            content
        }
    }
}

struct OverviewModel {
    var pageID: UUID
    var image: UIImage
}

struct OverviewIcon: View {
    
    @State var pageView: PageView?
    
    @Binding var document: Productivity_ProDocument
    let page: Page
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    let size: CGSize
    
    var body: some View {
        ZStack {
            pageView
                .scaleEffect(size.width / 4 / getFrame(page: page).width)
                .frame(
                    width: size.width / 4,
                    height: (size.width / 4 / getFrame(page: page).width) * getFrame(page: page).height
                )
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .allowsHitTesting(false)
                .disabled(true)
            
            RoundedRectangle(cornerRadius: 5)
                .stroke(
                    page.id == toolManager.selectedTab ? Color.accentColor : Color.secondary,
                    lineWidth: 2
                )
                .frame(
                    width: size.width / 4,
                    height: (size.width / 4 / getFrame(page: page).width) * getFrame(page: page).height
                )
        }
        .onAppear {
            let tm = ToolManager()
            tm.zoomScale = 1
            
            pageView = PageView(
                document: $document,
                page: .constant(page),
                toolManager: tm,
                subviewManager: subviewManager,
                showBackground: true,
                showToolView: true,
                showShadow: false,
                isOverview: true,
                size:
                    CGSize(
                        width: size.width / 4,
                        height: (size.width / 4 / getFrame(page: page).width) * getFrame(page: page).height
                    )
            )
        }
    }
    
    func getFrame(page: Page) -> CGSize {
        var frame: CGSize = .zero
        
        if page.isPortrait {
            frame = CGSize(width: shortSide, height: longSide)
        } else {
            frame = CGSize(width: longSide, height: shortSide)
        }
        
        return frame
    }
    
}

