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
    
    @State var showSize: Bool = false
    @State var showColor: Bool = false
    
    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .topBarLeading) {
            RTFFont()
            RTFFontSize()
            RTFDivider()
            RTFStyle()
            RTFColor()
        }
    }
    
    @ViewBuilder func RTFDivider() -> some View {
        HStack {
            Divider()
                .frame(height: 30)
        }
    }
}
