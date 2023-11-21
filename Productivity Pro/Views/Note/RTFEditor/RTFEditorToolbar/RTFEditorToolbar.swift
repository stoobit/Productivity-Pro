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
        
        ToolbarItemGroup(placement: .primaryAction) {
            RTFStyleToggle(context: context, style: .bold)
            RTFStyleToggle(context: context, style: .italic)
            RTFStyleToggle(context: context, style: .underlined)
            RTFStyleToggle(context: context, style: .strikethrough)
        }
        
    }
}
