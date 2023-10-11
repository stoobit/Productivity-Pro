//
//  NoteToolbarModifier.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.06.23.
//

import SwiftUI

struct NoteViewToolbar: ViewModifier {
    var contentObject: ContentObject
    
    func body(content: Content) -> some View {
        content
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.editor)
            .navigationTitle(contentObject.title)
            .toolbarTitleMenu {
                NoteTitleMenu(contentObject: contentObject)
            }
            .toolbar(id: "main") {
                NoteMainToolbar(contentObject: contentObject)
            }
            .toolbar {
                NoteSideActions(contentObject: contentObject)
            }
    }
}
