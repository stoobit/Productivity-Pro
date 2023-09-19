//
//  NoteViewAlert.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.09.23.
//

import SwiftUI

struct NoteViewAlert: ViewModifier {
    @Environment(\.undoManager) var undoManager
    
    @Binding var document: Document
    @Binding var url: URL
    
    @Bindable var subviewManager: SubviewManager
    @Bindable var toolManager: ToolManager
    
    @State var renameTitel: String = ""
    
    func body(content: Content) -> some View {
        content
            .alert(
                "Diese Seite löschen?",
                isPresented: $subviewManager.isDeletePageAlert,
                actions: {
                    Button("Seite löschen", role: .destructive) { deletePage() }
                    Button("Abbrechen", role: .cancel) { subviewManager.isDeletePageAlert.toggle()
                    }
                }
            ) {
                Text("Diese Aktion kann nicht rückgängig gemacht werde.")
            }
            .alert(getRenameTitle().0, isPresented: $subviewManager.renameView) {
                TextField(getRenameTitle().1, text: $renameTitel)
                Button("Umbenennen", role: .cancel) { rename() }
            }
        
    }
    
    func deletePage() {
        withAnimation {
            
            document.note.pages[
                toolManager.selectedPage
            ].items.removeAll()
            
            document.note.pages[
                toolManager.selectedPage
            ].type = .template
            
            toolManager.preloadedMedia.remove(at: toolManager.selectedPage)
            
            let seconds = 0.1
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                
                if toolManager.selectedTab == document.note.pages.last?.id {
                    
                    let newSelection = document.note.pages[toolManager.selectedPage - 1].id
                    document.note.pages.remove(at: toolManager.selectedPage)
                    
                    toolManager.selectedTab = newSelection
                    
                } else {
                    
                    let newSelection = document.note.pages[toolManager.selectedPage + 1].id
                    document.note.pages.remove(at: toolManager.selectedPage)
                    
                    toolManager.selectedTab = newSelection
                    
                }
                
                undoManager?.removeAllActions()
                toolManager.selectedItem = nil
                
            }
        }
    }
    
    func getRenameTitle() -> (String, String) {
        let title = url.lastPathComponent.string.dropLast(4)
        return ("\"\(title)\" umbennenen.", String(title))
    }
    
    func rename() {
        if renameTitel != "" {
            let old: URL = url
            
            url = url.deletingLastPathComponent().appendingPathComponent(
                renameTitel, conformingTo: .pro
            )
            
            if url.deletingLastPathComponent().startAccessingSecurityScopedResource() {
                do {
                    
                    try FileManager.default.moveItem(at: old, to: url)
                    
                } catch {}
                
                url.deletingLastPathComponent().stopAccessingSecurityScopedResource()
            }
            
            renameTitel = ""
        }
    }
    
}
