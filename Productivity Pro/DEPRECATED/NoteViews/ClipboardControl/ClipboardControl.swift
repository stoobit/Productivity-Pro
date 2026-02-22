//
//  ClipboardControl.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.12.23.
//

import SwiftUI

struct ClipboardControl: View {
    @Environment(\.modelContext) var context
    
    @Environment(SubviewManager.self) var subviewManager
    @Environment(ToolManager.self) var toolManager
    
    @AppStorage("defaultFont") var defaultFont: String = "Avenir Next"
    @AppStorage("defaultFontSize") var defaultFontSize: Double = 12
    
    @State var alert: Bool = false
    var size: CGSize

    var body: some View {
        Menu("Bearbeitungsoptionen", systemImage: "document.on.trash") {
            Button("Einfügen", systemImage: "doc.on.clipboard", action: paste)
                .keyboardShortcut(KeyEquivalent("v"), modifiers: .command)
                .disabled(subviewManager.showInspector)
            
            Button("Kopieren", systemImage: "document.on.document") {
                copy()
            }
            .keyboardShortcut(KeyEquivalent("c"), modifiers: .command)
            .disabled(subviewManager.showInspector)
            .disabled(toolManager.activeItem == nil)
            
            Button("Duplizieren", systemImage: "plus.square.on.square") {
                duplicate()
            }
            .keyboardShortcut(KeyEquivalent("d"), modifiers: .command)
            .disabled(subviewManager.showInspector)
            .disabled(toolManager.activeItem == nil)
        
            Button(role: .destructive, action: { cut() }) {
                Label("Ausschneiden", systemImage: "scissors")
            }
            .keyboardShortcut(KeyEquivalent("x"), modifiers: .command)
            .disabled(subviewManager.showInspector)
            .disabled(toolManager.activeItem == nil)
        
            Button(role: .destructive, action: { delete() }) {
                Label("Löschen", systemImage: "trash")
            }
            .keyboardShortcut(.delete, modifiers: [])
            .disabled(subviewManager.showInspector)
            .disabled(toolManager.activeItem == nil)
        }
        .alert(
            "Es konnte kein Objekt eingefügt werden.", isPresented: $alert
        ) {
            Button("Ok") { alert.toggle() }
        }
    }
}
