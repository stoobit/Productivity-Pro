//
//  RTFAlignment.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.11.23.
//

import SwiftUI
import RichTextKit

struct RTFAlignment: View {
    @StateObject var context: RichTextContext
    
    var body: some View {
        ControlGroup(content: {
            
            Button(action: { context.textAlignment = .left }) {
                Label("Left", systemImage: "text.alignleft")
            }
            
            Button(action: { context.textAlignment = .center }) {
                Label("Center", systemImage: "text.aligncenter")
            }
            
            Button(action: { context.textAlignment = .right }) {
                Label("Right", systemImage: "text.alignright")
            }
            
            Button(action: { context.textAlignment = .justified }) {
                Label("Justified", systemImage: "text.justify")
            }
            
        }) {
            Label("Alignment", systemImage: "text.alignleft")
        }
        .controlGroupStyle(.compactMenu)
        .disabled(context.isEditingText == false)
    }
}
