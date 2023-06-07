//
//  BottomOffset.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.11.22.
//

import SwiftUI

struct BottomPadding: ViewModifier {
    @Binding var document: ProductivityProDocument
    @Binding var page: Page
    
    func body(content: Content) -> some View {
        if document.document.note.pages.last! == page {
            content
        } else {
            content
                .padding(.bottom)
        }
    }
}
