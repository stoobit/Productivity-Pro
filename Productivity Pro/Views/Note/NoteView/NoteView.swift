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
    @Environment(\.scenePhase) var scenePhase
    
    let timer = Timer
        .publish(every: 180, tolerance: 120, on: .main, in: .common)
        .autoconnect()
    
    @Binding var document: Document
    @Binding var url: URL
    
    @Bindable var subviewManager: SubviewManager
    @Bindable var toolManager: ToolManager
    
    @State var drawingModel: PPDrawingModel = PPDrawingModel()
    
    var isCPMenuHidden: Bool {
        if subviewManager.isPresentationMode || toolManager.isCanvasEnabled {
            return true
        } else {
            return false
        }
    }
    
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
                    
                }
                .edgesIgnoringSafeArea(.bottom)
                .disabled(toolManager.showProgress)
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
                .onChange(of: toolManager.selectedTab) { old, tab in
                    selectedTabDidChange(tab, size: proxy.size)
                }
                .onChange(of: toolManager.selectedPage) { old, page in
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
                        url: $url,
                        toolManager: toolManager,
                        subviewManager: subviewManager
                    ) {
                        saveDocument()
                        dismiss()
                    }
                )
                .alert(
                    "Delete this Page",
                    isPresented: $subviewManager.isDeletePageAlert,
                    actions: {
                        Button("Delete Page", role: .destructive) { deletePage() }
                        Button("Cancel", role: .cancel) { subviewManager.isDeletePageAlert.toggle()
                        }
                        
                    }
                ) {
                    Text("You cannot undo this action.")
                }
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
                .sheet(isPresented: $subviewManager.sharePDFSheet) {
                    ShareSheet(
                        showProgress: $toolManager.showProgress,
                        subviewManager: subviewManager,
                        toolManager: toolManager,
                        document: $document,
                        type: .pdf
                    )
                }
            }
            .position(
                x: proxy.size.width / 2,
                y: proxy.size.height / 2
            )
        }
        .onChange(of: toolManager.pickedImage) {
            pickedImageDidChange()
        }
        .onChange(of: document.note.pages.count) {
            pageIndicator()
            undoManager?.removeAllActions()
        }
        .onAppear { noteDidAppear() }
        .onReceive(timer) { input in
            saveDocument()
        }
        .onReceive(NotificationCenter.default.publisher(
            for: UIApplication.willTerminateNotification)
        ) { output in
            saveDocument()
        }
        .onChange(of: scenePhase) {
            saveDocument()
        }
        .task {
            pageIndicator()
            loadMedia()
        }
        
        
    }
    
}
