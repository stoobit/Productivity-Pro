//
//  RTFEditorToolbar.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 13.12.23.
//

import SwiftUI
import RichTextKit

struct RTFEditorToolbar: ToolbarContent {
    @StateObject var context: RichTextContext
    @Binding var text: NSAttributedString
    
    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .topBarLeading) {
           RTFAlignment()
        }
    }
}
