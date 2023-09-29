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
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.undoManager) var undoManager
    
    @State var subviewManager: SubviewManager = SubviewManager()
    @State var toolManager: ToolManager = ToolManager()
    
    @State var drawingModel: PPDrawingModel = PPDrawingModel()
    @State var document: Document = Document()
    
    var file: ContentObject
    
    var body: some View {
        GeometryReader { proxy in
            
            if document.documentType != .none {
                NavigationStack {
                    ZStack {
                        Color(UIColor.secondarySystemBackground).ignoresSafeArea(edges: .all)
                        
                        TabView(selection: $toolManager.selectedTab) {
                            ForEach($document.note.pages) { $page in
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
                        .onChange(of: toolManager.selectedTab) { old, tab in
                            selectedTabDidChange(tab, size: proxy.size)
                        }
                        
                    }
                    .edgesIgnoringSafeArea(.bottom)
                    .overlay {
                        if toolManager.isPageNumberVisible {
                            IndicatorText(
                                document: document, toolManager: toolManager
                            )
                        }
                    }
                    .modifier(
                        NoteViewSheet(
                            document: $document,
                            subviewManager: subviewManager,
                            toolManager: toolManager,
                            proxy: proxy
                        )
                    )
                    .modifier(
                        NoteViewAlert(
                            document: $document,
                            subviewManager: subviewManager, toolManager: toolManager
                        )
                    )
                    .modifier(
                        NoteViewOnChange(
                            document: $document,
                            subviewManager: subviewManager, toolManager: toolManager,
                            pageIndicator: pageIndicator,
                            selectedImageDidChange: pickedImageDidChange
                        )
                    )
                    .modifier(
                        NoteViewToolbar(
                            document: $document,
                            toolManager: toolManager,
                            subviewManager: subviewManager
                        ) {
                            dismiss()
                        }
                    )
                    
                }
                .disabled(toolManager.showProgress)
                .position(
                    x: proxy.size.width / 2,
                    y: proxy.size.height / 2
                )
            }
            
        }
        .onAppear {}
    }
}
