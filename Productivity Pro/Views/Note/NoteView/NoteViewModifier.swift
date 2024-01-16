//
//  NoteViewModifier.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.10.23.
//

import SwiftUI

struct NoteViewModifier: ViewModifier {
    @Bindable var contentObject: ContentObject
    var reader: ScrollViewProxy

    func body(content: Content) -> some View {
        content
            .modifier(
                NoteViewToolbar(contentObject: contentObject)
            )
            .modifier(
                NoteViewSheet(
                    contentObject: contentObject, reader: reader
                )
            )
    }
}

extension View {
    func noteViewModifier(with object: ContentObject, reader: ScrollViewProxy) -> some View {
        modifier(NoteViewModifier(contentObject: object, reader: reader))
    }
}
