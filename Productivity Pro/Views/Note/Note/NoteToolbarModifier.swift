//
//  NoteToolbarModifier.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.06.23.
//

import SwiftUI

struct NoteToolbarModifier: ViewModifier {
    
    @Binding var document: ProductivityProDocument
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    func body(content: Content) -> some View {
        content
            .toolbarTitleMenu {
                NoteToolbarTitleMenu(
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
                NoteSideActionToolbar(
                    document: $document,
                    toolManager: toolManager,
                    subviewManager: subviewManager
                )
            }
    }
}