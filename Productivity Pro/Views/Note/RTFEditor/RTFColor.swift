//
//  RTFColor.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 14.12.23.
//

import RichTextKit
import SwiftUI

extension RTFEditorToolbar {
    @ViewBuilder func RTFColor() -> some View {
        Button(action: { showColor.toggle() }) {
            Label("Farbe", systemImage: "paintpalette")
        }
        .popover(isPresented: $showColor, arrowEdge: .trailing, content: {
            Form {
                HStack {
                    Text("Textfarbe")
                    Spacer()
                    RichTextColorPicker(color: .foreground, context: context, showIcon: false, quickPickerColors: [])
                }
                .frame(height: 30)
                
                HStack {
                    Text("Hintergrundfarbe")
                    Spacer()
                    RichTextColorPicker(color: .background, context: context, showIcon: false, quickPickerColors: [])
                }
                .frame(height: 30)
            }
            .environment(\.defaultMinListRowHeight, 10)
            .frame(width: 300, height: 170)
        })
    }
}
