//
//  NoteToolbarModifier.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.06.23.
//

import SwiftUI

struct NoteViewToolbar: ViewModifier {
    @Bindable var contentObject: ContentObject
    var size: CGSize
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden()
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
                NoteMainToolbar(contentObject: contentObject, size: size)
            }
    }
}
