//
//  RTFStyleToggle.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.11.23.
//

import SwiftUI
import RichTextKit

struct RTFStyleToggle: View {
    
    @StateObject var context: RichTextContext
    var style: RichTextStyle
    
    var body: some View {
        Group {
            if style == .strikethrough {
                
                Toggle(isOn: $context.isStrikethrough) {
                    Label("Strikethrough", systemImage: "strikethrough")
                        .frame(width: 40, height: 40)
                }
                
            } else if style == .underlined {
                
                Toggle(isOn: $context.isUnderlined) {
                    Label("Underlined", systemImage: "underline")
                }
                
            } else if style == .bold {
                
                Toggle(isOn: $context.isBold) {
                    Label("Bold", systemImage: "bold")
                }
                
            } else if style == .italic {
                
                Toggle(isOn: $context.isItalic) {
                    Label("Italic", systemImage: "italic")
                }
                
            }
        }
        .toggleStyle(.button)
    }
}
