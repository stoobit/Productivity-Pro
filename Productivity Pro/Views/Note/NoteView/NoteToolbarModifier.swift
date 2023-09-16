//
//  NoteToolbarModifier.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.06.23.
//

import SwiftUI

struct NoteToolbarModifier: ViewModifier {
    
    @Binding var document: Document
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    var url: URL
    
    func body(content: Content) -> some View {
        content
            .toolbarRole(.editor)
            .toolbarTitleMenu {
                NoteToolbarTitleMenu(
                    document: $document,
                    subviewManager: subviewManager,
                    toolManager: toolManager,
                    url: url
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
                NoteSideActionToolbar(
                    document: $document,
                    toolManager: toolManager,
                    subviewManager: subviewManager
                )
            }
    }
}
