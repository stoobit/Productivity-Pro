//
//  NoteToolbarModifier.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.06.23.
//

import SwiftUI

struct NoteViewToolbar: ViewModifier {
    @Bindable var contentObject: ContentObject
    
    func body(content: Content) -> some View {
        content
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.editor)
            .toolbarTitleMenu {
                NoteTitleMenu(contentObject: contentObject)
            }
            .toolbar {
                NoteSecondaryToolbar(contentObject: contentObject)
            }
            .toolbar(id: "customizable") {
                NoteMainToolbar(contentObject: contentObject)
            }
    }
}
