//
//  ClipboardControl.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.12.23.
//

import SwiftUI

struct ClipboardControl: View {
    @Environment(ToolManager.self) var toolManager
    @Environment(\.modelContext) var context

    var body: some View {
        HStack {
            Button(action: {}) {
                ClipboardButton(image: "doc.on.clipboard")
            }
            
            Button(action: {}) {
                ClipboardButton(image: "doc.on.doc")
            }
            .disabled(toolManager.activeItem == nil)
            
            Button(action: {}) {
                ClipboardButton(image: "plus.square.on.square")
            }
            .disabled(toolManager.activeItem == nil)
            
            Button(role: .destructive, action: {}) {
                ClipboardButton(image: "scissors")
            }
            .disabled(toolManager.activeItem == nil)
            
            Button(role: .destructive, action: { delete() }) {
                ClipboardButton(image: "trash")
            }
            .disabled(toolManager.activeItem == nil)
        }
        .padding(5)
        .background {
            RoundedRectangle(cornerRadius: 14)
                .foregroundStyle(.thinMaterial)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .bottomLeading
        )
    }
    
    @ViewBuilder func ClipboardButton(image: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 11.5)
                .foregroundStyle(.background)
                .frame(width: 45, height: 45)
        
            Image(systemName: image)
        }
    }
}

#Preview {
    ClipboardControl()
        .background(Color.red)
        .environment(ToolManager())
        .padding()
        .ignoresSafeArea(.all)
}
