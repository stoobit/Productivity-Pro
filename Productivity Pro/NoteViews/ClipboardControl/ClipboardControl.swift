//
//  ClipboardControl.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.12.23.
//

import SwiftUI

struct ClipboardControl: View {
    @Environment(SubviewManager.self) var subviewManager
    @Environment(ToolManager.self) var toolManager
    
    @Environment(\.modelContext) var context
    
    @AppStorage("defaultFont") var defaultFont: String = "Avenir Next"
    @AppStorage("defaultFontSize") var defaultFontSize: Double = 12
    
    @State var alert: Bool = false
    var size: CGSize

    var body: some View {
        ZStack {
            HStack {
                Button(action: { paste() }) {
                    ClipboardButton(image: "doc.on.clipboard")
                }
                .keyboardShortcut(KeyEquivalent("v"), modifiers: .command)
                .disabled(subviewManager.showInspector)
                .alert(
                    "Es konnte kein Objekt eingefügt werden.", isPresented: $alert
                ) {
                    Button("Ok") { alert.toggle() }
                }
            
                Button(action: { copy() }) {
                    ClipboardButton(image: "doc.on.doc")
                }
                .keyboardShortcut(KeyEquivalent("c"), modifiers: .command)
                .disabled(subviewManager.showInspector)
                .disabled(toolManager.activeItem == nil)
            
                Button(action: { duplicate() }) {
                    ClipboardButton(image: "plus.square.on.square")
                }
                .keyboardShortcut(KeyEquivalent("d"), modifiers: .command)
                .disabled(subviewManager.showInspector)
                .disabled(toolManager.activeItem == nil)
            
                Button(role: .destructive, action: { cut() }) {
                    ClipboardButton(image: "scissors")
                }
                .keyboardShortcut(KeyEquivalent("x"), modifiers: .command)
                .disabled(subviewManager.showInspector)
                .disabled(toolManager.activeItem == nil)
            
                Button(role: .destructive, action: { delete() }) {
                    ClipboardButton(image: "trash")
                }
                .keyboardShortcut(.delete, modifiers: [])
                .disabled(subviewManager.showInspector)
                .disabled(toolManager.activeItem == nil)
            }
            .disabled(toolManager.isEditingText)
            .padding(5)
            .background {
                RoundedRectangle(cornerRadius: 14)
                    .foregroundStyle(.thinMaterial)
            }
            .disabled(toolManager.pencilKit)
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
