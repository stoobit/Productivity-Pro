//
//  NoteViewModifier.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.10.23.
//

import SwiftUI

struct NoteViewModifier: ViewModifier {
    @Bindable var contentObject: ContentObject
    var size: CGSize

    func body(content: Content) -> some View {
        content
            .modifier(
                NoteViewToolbar(contentObject: contentObject, size: size)
            )
            .modifier(
                NoteViewSheet(contentObject: contentObject, size: size)
            )
    }
}

extension View {
    func noteViewModifier(
        with object: ContentObject, size: CGSize
    ) -> some View {
        modifier(NoteViewModifier(contentObject: object, size: size))
    }
}
