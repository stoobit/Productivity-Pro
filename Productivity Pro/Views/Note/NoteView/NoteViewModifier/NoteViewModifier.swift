//
//  NoteViewModifier.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.10.23.
//

import SwiftUI

struct NoteViewModifier: ViewModifier {
    var contentObject: ContentObject
    
    func body(content: Content) -> some View {
        content
            .modifier(NoteViewToolbar(contentObject: contentObject))
    }
}

extension View {
    func noteViewModifier(with contentObject: ContentObject) -> some View {
        modifier(NoteViewModifier(contentObject: contentObject))
    }
}
