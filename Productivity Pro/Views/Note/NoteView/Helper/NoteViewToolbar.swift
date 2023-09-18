//
//  NoteToolbarModifier.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.06.23.
//

import SwiftUI

struct NoteViewToolbar: ViewModifier {
    
    @Binding var document: Document
    @Binding var url: URL
    
    @Bindable var toolManager: ToolManager
    @Bindable var subviewManager: SubviewManager
    
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden()
            .navigationTitle(url.lastPathComponent.string.dropLast(4))
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .navigationDocument(url)
            .toolbarRole(.editor)
            .toolbarTitleMenu {
                NoteTitleMenu(
                    document: $document,
                    url: $url,
                    subviewManager: subviewManager,
                    toolManager: toolManager
                )
            }
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
                NoteSideActions(
                    document: $document, url: $url,
                    toolManager: toolManager,
                    subviewManager: subviewManager,
                    dismissAction: action
                )
            }
    }
}
