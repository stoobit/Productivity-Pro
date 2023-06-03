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
    
   @AppStorage("fullAppUnlocked") var isFullAppUnlocked: Bool = false
    @AppStorage("startDate") var startDate: String = ""
    
    @Binding var document: Productivity_ProDocument
    
    @StateObject var subviewManager: SubviewManager
    @StateObject var toolManager: ToolManager
    
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
                Color(UIColor.secondarySystemBackground).ignoresSafeArea(
                    .all, edges: .all
                )
                
                TabView(selection: $toolManager.selectedTab) {
                    ForEach($document.document.note.pages) { $page in
                        ZoomableScrollView(
                            size: proxy.size,
                            document: $document,
                            page: $page,
                            toolManager: toolManager,
                            subviewManager: subviewManager
                        ) {
                            PageView(
                                document: $document,
                                page: $page,
                                toolManager: toolManager,
                                subviewManager: subviewManager,
                                showBackground: true,
                                showToolView: false,
                                showShadow: true,
                                size: proxy.size
                            )
                        }
                        .modifier(
                            OrientationUpdater(isPortrait: $page.isPortrait)
                        )
                        .id(page.id)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .onChange(of: toolManager.selectedTab) { tab in
                    toolManager.selectedPage = document.document.note.pages.firstIndex(where: {
                        $0.id == tab
                    }) ?? 0
                    
                    toolManager.selectedItem = nil
                    toolManager.scrollOffset = .zero
                    toolManager.zoomScale = getScale(
                        toolManager.selectedPage, size: proxy.size
                    )
                }
                .onChange(of: toolManager.selectedPage) { page in
                    toolManager.selectedTab = document.document.note.pages[page].id
                }
                .onAppear {
                    UITabBar.appearance().isHidden = true
                    checkLockStatus()
                    
                    toolManager.selectedPage = 0
                    
                    toolManager.selectedTab = document.document.note.pages[
                        toolManager.selectedPage
                    ].id
                    
                    fixScrollViewBug()
                }
                .frame(height: proxy.size.height + 30)
                .offset(y: 30/4)
                
            }
            .overlay {
                ZStack {
                    if toolManager.isPageNumberVisible {
                        IndicatorText(
                            document: document, toolManager: toolManager
                        )
                    }
                    
                    if UIDevice.current.userInterfaceIdiom != .phone {
                        CopyPasteMenuView(document: $document, toolManager: toolManager)
                            .offset(y: isCPMenuHidden ? 100 : 0)
                            .animation(
                                .easeInOut(duration: 0.2),
                                value: isCPMenuHidden
                            )
                    }
                    
                }
                .frame(height: proxy.size.height)
            }
            .modifier(
                ToolbarTitleMenuVisibility(
                    document: $document,
                    subviewManager: subviewManager,
                    toolManager: toolManager
                )
            )
            .toolbar(id: "main") {
                if subviewManager.isPresentationMode == false {
                    NoteMainToolToolbar(
                        document: $document,
                        toolManager: toolManager,
                        subviewManager: subviewManager
                    )
                }
            }
            .toolbar {
                
                if UIDevice.current.userInterfaceIdiom == .pad {
                    
                    NoteSideActionToolbar(document: $document, toolManager: toolManager, subviewManager: subviewManager)
                    
                } else if UIDevice.current.userInterfaceIdiom == .phone {
                    
                    iPhoneActionsToolbar(
                        document: $document,
                        toolManager: toolManager,
                        subviewManager: subviewManager
                    )
                    
                }
            }
            .onChange(of: toolManager.pickedImage) { _ in
                if let image = toolManager.pickedImage { addImage(image) }
                toolManager.pickedImage = nil
            }
            .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
            .modifier(SheetHelper(
                document: $document,
                subviewManager: subviewManager,
                toolManager: toolManager
            ) {
                
            })
            .sheet(isPresented: $subviewManager.showTextEditor) {
                EditTextView(
                    document: $document,
                    toolManager: toolManager,
                    subviewManager: subviewManager,
                    size: proxy.size
                )
                .edgesIgnoringSafeArea(.all)
            }
            .sheet(isPresented: $subviewManager.showDebuggingSheet) {
                DebuggingSheet(
                    document: $document,
                    toolManager: toolManager,
                    subviewManager: subviewManager
                )
            }
        }
        .onDisappear { resetControls() }
        .onChange(of: toolManager.selectedPage) { _ in pageIndicator() }
        .onChange(of: document.document.note.pages.count) { _ in pageIndicator() }
        .task { pageIndicator() }
        .alert("Delete this Page", isPresented: $subviewManager.isDeletePageAlert, actions: {
                Button("Delete Page", role: .destructive) { removePage() }
            Button("Cancel", role: .cancel) { subviewManager.isDeletePageAlert.toggle() }
            
        }, message: { Text("You cannot undo this action.") })
        .sheet(
            isPresented: $subviewManager.addPageSettingsSheet,
            onDismiss: { undoManager?.removeAllActions() }) {
            AddPageView(
                document: $document, isPresented: $subviewManager.addPageSettingsSheet, toolManager: toolManager
            )
        }
        
    }
    
}

struct ToolbarTitleMenuVisibility: ViewModifier {
    
    @Binding var document: Productivity_ProDocument
    
    @StateObject var subviewManager: SubviewManager
    @StateObject var toolManager: ToolManager
    
    func body(content: Content) -> some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            content
                .toolbarTitleMenu {
                    NoteToolbarTitleMenu(
                        document: $document,
                        subviewManager: subviewManager,
                        toolManager: toolManager
                    )
                }
            
        } else { content }
        
    }
}
