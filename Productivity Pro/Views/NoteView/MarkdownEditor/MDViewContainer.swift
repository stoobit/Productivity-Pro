//
//  MDViewContainer.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 02.03.24.
//

import SwiftUI

struct MDViewContainer: ViewModifier {
    @AppStorage("isMarkdownf") var markdownFullscreen: Bool = false
    @Binding var isPresented: Bool
    
    func body(content: Content) -> some View {
        if markdownFullscreen {
            content
                .fullScreenCover(isPresented: $isPresented, content: {
                    MDEditorView()
                        .interactiveDismissDisabled()
                })
        } else {
            content
                .sheet(isPresented: $isPresented, content: {
                    MDEditorView()
                        .interactiveDismissDisabled()
                })
        }
    }
}
