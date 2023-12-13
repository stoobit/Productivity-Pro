//
//  RTFAlignment.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 13.12.23.
//

import SwiftUI
import RichTextKit

extension RTFEditorToolbar {
    @ViewBuilder func RTFAlignment() -> some View {
        ControlGroup(content: {
            
            Button("Links", systemImage: "text.alignleft") {
                setAlignment(to: .left)
            }
            
            Button("Mittig", systemImage: "text.aligncenter") {
                setAlignment(to: .center)
            }
            
            Button("Rechts", systemImage: "text.alignright") {
                setAlignment(to: .right)
            }
            
        }) {
            Label("Textausrichtung", systemImage: "text.alignleft")
        }
        .controlGroupStyle(.compactMenu)
    }
    
    func setAlignment(to alignment: NSTextAlignment) {
        let style = NSMutableParagraphStyle()
        style.alignment = alignment
        
        
        let mutable = NSMutableAttributedString(attributedString: text)
        mutable.addAttribute(
            .paragraphStyle, value: alignment, range: text.richTextRange
        )
        
        text = mutable.attributedString
        context.textAlignment = RichTextAlignment(alignment)
    }
}
