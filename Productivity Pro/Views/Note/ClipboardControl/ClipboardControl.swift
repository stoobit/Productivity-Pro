//
//  ClipboardControl.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.12.23.
//

import SwiftUI

struct ClipboardControl: View {
    @Environment(ToolManager.self)
    var toolManager

    var body: some View {
        HStack {
            Button(action: {}) {
                ZStack {
                    RoundedRectangle(cornerRadius: 11.5)
                        .foregroundStyle(.thinMaterial)
                        .frame(width: 45, height: 45)
                
                    Image(systemName: "doc.on.clipboard")
                }
            }
        
            ControlGroup(content: {
                Button("Kopieren", systemImage: "doc.on.doc") {}
                
                Button("Duplizieren", systemImage: "plus.square.on.square") {}
                
                Button("Ausschneiden", systemImage: "scissors", role: .destructive) {}
                
                Button("Löschen", systemImage: "trash", role: .destructive) {}
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 11.5)
                        .foregroundStyle(.thinMaterial)
                        .frame(width: 45, height: 45)
                    
                    Image(systemName: "scissors.badge.ellipsis")
                }
            }
            .controlGroupStyle(.compactMenu)
        }
        .padding(5)
        .background {
            RoundedRectangle(cornerRadius: 14)
                .foregroundStyle(.background)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .bottomLeading
        )
    }
}

#Preview {
    ClipboardControl()
        .background(Color.red)
        .environment(ToolManager())
        .padding()
        .ignoresSafeArea(.all)
}
