//
//  SecondaryShareAction.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.10.23.
//

import SwiftUI

extension NoteSecondaryToolbar {
    @ViewBuilder func ShareAction() -> some View {
        Menu(content: {
            
            Button("Notiz", systemImage: "doc") {
                subviewManager.shareProView.toggle()
            }
            
            Button("PDF", systemImage: "doc.richtext") {
                subviewManager.sharePDFView.toggle()
            }
            
        }) {
            Label("Teilen", systemImage: "square.and.arrow.up")
        }
    }
}
