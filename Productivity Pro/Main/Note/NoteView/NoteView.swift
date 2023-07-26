//
//  NoteView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.22.
//

import SwiftUI
import PencilKit
import PDFKit

struct NoteView: View {
    
    @Environment(\.undoManager) var undoManager
    @Binding var document: ProductivityProDocument
    
    @StateObject var subviewManager: SubviewManager
    @StateObject var toolManager: ToolManager
    
    @StateObject var drawingModel: PPDrawingModel = PPDrawingModel()
    
    var isCPMenuHidden: Bool {
        if subviewManager.isPresentationMode || toolManager.isCanvasEnabled {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color(UIColor.secondarySystemBackground).ignoresSafeArea(edges: .bottom)
                
                NoteNextPage(
                    pages: $document.document.note.pages,
                    toolManager: toolManager
                )
                
                TabView(selection: $toolManager.selectedTab) {
                    ForEach($document.document.note.pages) { $page in
                        ScrollViewWrapper(
                            size: proxy.size,
                            document: $document,
                            page: $page,
                            toolManager: toolManager,
                            subviewManager: subviewManager,
                            drawingModel: drawingModel
                        )
                        .id(page.id)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: proxy.size.height + 30)
                .offset(y: 30/4)
                
            }
            .position(
                x: proxy.size.width / 2,
                y: proxy.size.height / 2
            )
            .overlay {
                NoteOverlayControlView(
                    document: $document,
                    toolManager: toolManager,
                    subviewManager: subviewManager,
                    drawingModel: drawingModel,
                    size: proxy.size,
                    isCPMenuHidden: isCPMenuHidden
                )
            }
            .onChange(of: toolManager.selectedTab) { tab in
                selectedTabDidChange(tab, size: proxy.size)
            }
            .onChange(of: toolManager.selectedPage) { page in
                selectedPageDidChange(index: page)
            }
            .modifier(
                NoteSheetHelper(
                    document: $document,
                    subviewManager: subviewManager,
                    toolManager: toolManager,
                    proxy: proxy
                )
            )
            .modifier(
                NoteToolbarModifier(
                    document: $document,
                    toolManager: toolManager,
                    subviewManager: subviewManager
                )
            )
            .alert(
                "Delete this Page",
                isPresented: $subviewManager.isDeletePageAlert,
                actions: {
                    Button("Delete Page", role: .destructive) { deletePage() }
                    Button("Cancel", role: .cancel) { subviewManager.isDeletePageAlert.toggle()
                    }
                    
                }) {
                    Text("You cannot undo this action.")
                }
        }
        .onChange(of: toolManager.pickedImage) { _ in
            pickedImageDidChange()
        }
        .onChange(of: document.document.note.pages.count) { _ in pageIndicator()
            undoManager?.removeAllActions()
        }
        .onAppear { noteDidAppear() }
        .task {
            pageIndicator()
            loadMedia()
        }
        
    }
    
}
