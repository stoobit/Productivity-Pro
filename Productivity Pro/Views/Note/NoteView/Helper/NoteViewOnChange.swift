//
//  NoteViewOnChange.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.09.23.
//

import SwiftUI
import PDFKit

struct NoteViewOnChange: ViewModifier {
    
    @Environment(\.undoManager) var undoManager
    @Environment(\.scenePhase) var scenePhase
    
    let timer = Timer
        .publish(every: 180, tolerance: 120, on: .main, in: .common)
        .autoconnect()
    
    @Binding var document: Document
    
    @Bindable var subviewManager: SubviewManager
    @Bindable var toolManager: ToolManager
    
    let saveDocument: () -> Void
    let pageIndicator: () -> Void
    let selectedImageDidChange: () -> Void
    
    func body(content: Content) -> some View {
        content
            .onChange(of: toolManager.pickedImage) {
                selectedImageDidChange()
            }
            .onChange(of: document.note.pages.count) {
                pageIndicator()
                undoManager?.removeAllActions()
            }
            .onChange(of: scenePhase) {
                saveDocument()
            }
            .onChange(of: toolManager.selectedPage) { old, page in
                selectedPageDidChange(index: page)
            }
            .onReceive(timer) { input in
                saveDocument()
            }
            .onReceive(NotificationCenter.default.publisher(
                for: UIApplication.willTerminateNotification)
            ) { output in
                saveDocument()
            }
            .onAppear { noteDidAppear() }
            .task {
                pageIndicator()
                loadMedia()
            }
    }
    
    func noteDidAppear() {
        loadFirst()
        
        toolManager.selectedTab = document.note.pages.first!.id
        toolManager.selectedPage = document.note.pages.firstIndex(
            where: { $0.id == toolManager.selectedTab }
        )!
    }
    
    func loadFirst() {
        guard let page = document.note.pages.first else { return }
        if page.type == .pdf {
            
            guard let data = page.backgroundMedia else {
                toolManager.preloadedMedia.append(nil)
                return
            }
            
            guard let pdf = PDFDocument(data: data) else {
                toolManager.preloadedMedia.append(nil)
                return
            }
            
            toolManager.preloadedMedia.append(pdf)
            
        } else {
            toolManager.preloadedMedia.append(nil)
        }
    }
    
    func loadMedia() {
        for page in Array(document.note.pages.dropFirst()) {
            if page.type == .pdf {
                
                guard let data = page.backgroundMedia else {
                    toolManager.preloadedMedia.append(nil)
                    continue
                }
                
                guard let pdf = PDFDocument(data: data) else {
                    toolManager.preloadedMedia.append(nil)
                    continue
                }
                
                toolManager.preloadedMedia.append(pdf)
                
            } else {
                toolManager.preloadedMedia.append(nil)
            }
        }
    }
    
    func selectedPageDidChange(index page: Int) {
        toolManager.selectedTab = document.note.pages[
            page
        ].id
    }
    
}
