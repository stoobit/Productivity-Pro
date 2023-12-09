//
//  RTFEditorToolbar.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.11.23.
//

import SwiftUI
import RichTextKit

struct RTFEditorToolbar: ToolbarContent {
    @StateObject var context: RichTextContext
    
    var body: some ToolbarContent {
        
        ToolbarItemGroup(placement: .topBarLeading) {
            Group {
                RTFStyle(context: context)
                RTFAlignment(context: context)
                RichTextFontSizePicker(selection: $context.fontSize)
                RTFFont(context: context)
            }
            .tint(Color.primary)
        }
        
    }
}
