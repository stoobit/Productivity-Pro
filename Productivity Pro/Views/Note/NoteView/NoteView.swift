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
    
    @Binding var document: Document
    @Binding var url: URL
    
    @Bindable var subviewManager: SubviewManager
    @Bindable var toolManager: ToolManager
    
    @State var drawingModel: PPDrawingModel = PPDrawingModel()
    
    var body: some View {
        GeometryReader { proxy in
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
                        document: $document, url: $url,
                        subviewManager: subviewManager,
                        toolManager: toolManager, 
                        proxy: proxy
                    )
                )
                .modifier(
                    NoteViewAlert(
                        document: $document, url: $url,
                        subviewManager: subviewManager, toolManager: toolManager
                    )
                )
                .modifier(
                    NoteViewOnChange(
                        document: $document, url: $url, 
                        subviewManager: subviewManager, toolManager: toolManager, 
                        saveDocument: saveDocument, pageIndicator: pageIndicator,
                        selectedImageDidChange: pickedImageDidChange
                    )
                )
                .modifier(
                    NoteViewToolbar(
                        document: $document,
                        url: $url,
                        toolManager: toolManager,
                        subviewManager: subviewManager
                    ) {
                        saveDocument()
                        dismiss()
                    }
                )
                .overlay {
                    if toolManager.showProgress {
                        ProgressView("Processing...")
                            .progressViewStyle(.circular)
                            .tint(.accentColor)
                            .frame(width: 175, height: 100)
                            .background(.thickMaterial)
                            .cornerRadius(13, antialiased: true)
                    }
                }
                
            }
            .disabled(toolManager.showProgress)
            .position(
                x: proxy.size.width / 2,
                y: proxy.size.height / 2
            )
            
        }
    }
}
