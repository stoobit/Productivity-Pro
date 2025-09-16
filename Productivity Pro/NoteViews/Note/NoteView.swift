//
//  NoteView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.22.
//

import SwiftData
import SwiftUI

struct NoteView: View {
    @Environment(ToolManager.self) var toolManager
    @Environment(SubviewManager.self) var subviewManager
    
    var contentObjects: [ContentObject]
    @Bindable var contentObject: ContentObject
    
    @State var pvModel: PagingViewModel = .init()
    
    var pages: [PPPageModel] {
        contentObject.note!.pages!
            .sorted(by: { $0.index < $1.index })
    }
    
    var body: some View {
        if contentObject.note?.pages != nil && !contentObject.inTrash {
            @Bindable var subviewValue = subviewManager
            @Bindable var toolValue = toolManager
            
            GeometryReader { proxy in
                ZStack {
                    Color(UIColor.secondarySystemBackground)
                        .ignoresSafeArea(.all, edges: .all)
                    
                    PagingViewController(
                        pages: pages.map {
                            ScrollViewContainer(
                                note: contentObject.note!, page: $0,
                                proxy: proxy
                            )
                            .environment(toolManager)
                            .environment(subviewManager)
                            .environment(pvModel)
                            .id(pages[pvModel.index].isPortrait)
                            
                        }, currentPage: $pvModel.index
                    )
                    .id(pages.count)
                    .id(proxy.size.width)
                }
                .noteViewModifier(with: contentObject, size: proxy.size)
                .onChange(of: pvModel.index) { updateIndex() }
                .onAppear { onAppear() }
                .overlay {
                    PrinterViewContainer(contentObject: contentObject)
                }
                .toolbar {
                    ClipboardControl(size: proxy.size)
                    ToolbarSpacer(.flexible, placement: .bottomBar)
                }
            }
            .ignoresSafeArea(.all, edges: .all)
            .navigationTitle(contentObject.title)
            .navigationSubtitle(page())
            .scrollEdgeEffectHidden()
            .background {
                Button("Widerrufen") {
                    toolManager.activePage?.undo(
                        toolManager: toolManager
                    )
                    toolManager.update += 1
                }
                .keyboardShortcut(KeyEquivalent("z"), modifiers: .command)
                
                Button("Wiederherstellen") {
                    toolManager.activePage?.redo(toolManager: toolManager)
                    toolManager.update += 1
                }
                .keyboardShortcut(KeyEquivalent("z"), modifiers: [
                    .command, .shift
                ])
                
                Color(UIColor.secondarySystemBackground)
                    .ignoresSafeArea(.all, edges: [.top, .horizontal])
            }
            .modifier(
                RenameContentObjectView(
                    contentObjects: contentObjects,
                    object: contentObject,
                    isPresented: $subviewValue.renameView
                )
            )
            .onChange(of: toolValue.activePage, initial: true) {
                toolManager.pencilKit = false
            }
            .environment(pvModel)
            .allowsHitTesting(pvModel.didAppear)
            .overlay {
                self.LoadingView()
            }
            .ignoresSafeArea(.keyboard, edges: .all)
            
        } else {
            ZStack {
                Color(UIColor.secondarySystemBackground)
                    .ignoresSafeArea(.all, edges: [.top, .horizontal])
                
                ContentUnavailableView(
                    "Ein Fehler ist aufgetreten.",
                    systemImage: "exclamationmark.triangle.fill"
                )
            }
        }
    }
    
    func onAppear() {
        if pvModel.didAppear == false {
            Task { @MainActor in
                let recent: Int = contentObject.note?.recent?.index ?? 0
            
                var pages = pages.map(\.index)
                pages.append(recent)
            
                for page in pages {
                    pvModel.index = page
                    try await Task.sleep(nanoseconds: 300000000)
                }
                
                pvModel.index = pages.last ?? 0
                toolManager.activePage = self.pages[pvModel.index]
                
                withAnimation(.smooth(duration: 0.2)) {
                    pvModel.didAppear = true
                }
            }
            
        } else {
            if pages.indices.contains(pvModel.index) {
                toolManager.activePage = pages[pvModel.index]
            }
        }
    }
    
    func updateIndex() {
        if pages.indices.contains(pvModel.index) {
            toolManager.activePage = pages[pvModel.index]
        }
        
        toolManager.activeItem = nil
    }
    
    func page() -> String {
        let total = pages.count
        let number = (toolManager.activePage?.index ?? 0) + 1
        
        return "\(number) von \(total)"
    }
    
    @ViewBuilder func LoadingView() -> some View {
        if pvModel.didAppear == false {
            ZStack {
                Color(UIColor.secondarySystemBackground)
                    .ignoresSafeArea(.all)
                
                ProgressView()
                    .controlSize(.extraLarge)
            }
            .transition(.opacity)
        }
    }
}
