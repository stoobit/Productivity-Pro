//
//  RTFFontSize.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 14.12.23.
//

import SwiftUI

extension RTFEditorToolbar {
    @ViewBuilder func RTFFontSize() -> some View {
        Button(action: { showSize.toggle() }) {
            Label("Schriftgröße", systemImage: "textformat.size")
        }
        .popover(isPresented: $showSize, arrowEdge: .trailing, content: {
            Form {
                Stepper("Schriftgröße", value: $context.fontSize, in: 1...200)
                    .frame(height: 30)
                Slider(value: $context.fontSize, in: 1...200, step: 1)
                    .frame(height: 30)
            }
            .environment(\.defaultMinListRowHeight, 10)
            .frame(width: 300, height: 170)
        })
        
    }
}
