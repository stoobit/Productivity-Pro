//
//  RTFFont.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.12.23.
//

import SwiftUI
import RichTextKit

struct RTFFont: View {
    @StateObject var context: RichTextContext
    
    var body: some View {
        Menu(content: {
            Picker("", selection: $context.fontName, content: {
                ForEach(UIFont.familyNames, id: \.self) { font in
                    Text(font)
                        .tag(font)
                }
            })
            .labelsHidden()
        }) {
            Image(systemName: "textformat.abc")
        }
    }
}
