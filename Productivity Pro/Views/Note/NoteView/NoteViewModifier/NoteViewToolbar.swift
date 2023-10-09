//
//  NoteToolbarModifier.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.06.23.
//

import SwiftUI

struct NoteViewToolbar: ViewModifier {
    
    @Binding var document: Document
    
    @Bindable var toolManager: ToolManager
    @Bindable var subviewManager: SubviewManager
    
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden()
//            .navigationTitle(url.lastPathComponent.string.dropLast(4))
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.editor)
            .toolbarTitleMenu {
                NoteTitleMenu(
                    document: $document,
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
                    document: $document,
                    toolManager: toolManager,
                    subviewManager: subviewManager,
                    dismissAction: action
                )
            }
    }
}
