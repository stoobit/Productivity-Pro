//
//  RTFFont.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 14.12.23.
//

import SwiftUI
import RichTextKit

extension RTFEditorToolbar {
    @ViewBuilder func RTFFont() -> some View {
        Menu(content: {
            Picker("Schriftart", selection: $context.fontName) {
                ForEach(UIFont.familyNames, id: \.self) { font in
                    Text(font)
                        .tag(font)
                }
            }
            .labelsHidden()
        }) {
            Label("Schriftart", systemImage: "textformat.abc")
        }
    }
}
