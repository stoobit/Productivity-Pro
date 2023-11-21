//
//  RTFStyleToggle.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.11.23.
//

import SwiftUI
import RichTextKit

struct RTFStyle: View {
    @StateObject var context: RichTextContext
    
    var body: some View {
        ControlGroup(content: {
            
            Button(action: { context.isItalic.toggle() }) {
                Label("Italic", systemImage: "italic")
            }
            
            Button(action: { context.isBold.toggle() }) {
                Label("Bold", systemImage: "bold")
            }
            
            Button(action: { context.isUnderlined.toggle() }) {
                Label("Underlined", systemImage: "underline")
            }
            
            Button(action: { context.isStrikethrough.toggle() }) {
                Label("Strikethrough", systemImage: "strikethrough")
            }
            
        }) {
            Label("Bold, Italic, Underline, Strikethrough", systemImage: "bold.italic.underline")
        }
        .controlGroupStyle(.compactMenu)
        .disabled(context.isEditingText == false)
    }
}
