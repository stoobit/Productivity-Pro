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
                    Text("stoobit")
                        .foregroundStyle(.clear)
                    
                    PageViewController(
                        pages: pages.map {
                            ScrollViewContainer(
                                note: contentObject.note!,
                                page: $0,
                                size: proxy.size
                            )
                        }, currentPage: $toolValue.index
                    )
                    .id(pages.count)
                    .id(proxy.size.width)
                }
                .noteViewModifier(with: contentObject)
                .onChange(of: toolManager.index) {
                    toolManager.activePage = pages[toolManager.index]
                        
                    toolManager.activeItem = nil
                    contentObject.note?.recent = toolManager.activePage
                }
                .onAppear {
                    if let recent = contentObject.note?.recent {
                        toolValue.activePage = recent
                        toolValue.index = recent.index
                    } else {
                        toolValue.activePage = pages.first
                    }
                }
                .onDisappear {
                    toolValue.index = 0
                }
            }
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
            .overlay {
                ClipboardControl()
                    .padding(10)
                
                IndicatorText(contentObject: contentObject)
                PrinterViewContainer(contentObject: contentObject)
            }
            
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
}
