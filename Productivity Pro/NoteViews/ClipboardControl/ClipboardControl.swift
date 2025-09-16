//
//  ClipboardControl.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.12.23.
//

import SwiftUI

struct ClipboardControl: ToolbarContent {
    @Environment(\.modelContext) var context
    
    @Environment(SubviewManager.self) var subviewManager
    @Environment(ToolManager.self) var toolManager
    
    @AppStorage("defaultFont") var defaultFont: String = "Avenir Next"
    @AppStorage("defaultFontSize") var defaultFontSize: Double = 12
    
    @State var alert: Bool = false
    var size: CGSize

    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .bottomBar) {
            Button("Einfügen", systemImage: "doc.on.clipboard") {
                paste()
            }
            .padding()
            .keyboardShortcut(KeyEquivalent("v"), modifiers: .command)
            .disabled(subviewManager.showInspector)
            .alert(
                "Es konnte kein Objekt eingefügt werden.", isPresented: $alert
            ) {
                Button("Ok") { alert.toggle() }
            }
            
            
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
        }
        
        ToolbarSpacer(.fixed, placement: .bottomBar)
        
        ToolbarItemGroup(placement: .bottomBar) {
            Button(role: .destructive, action: { cut() }) {
                Label("Ausschneiden", systemImage: "scissors")
            }
            .tint(Color.red)
            .keyboardShortcut(KeyEquivalent("x"), modifiers: .command)
            .disabled(subviewManager.showInspector)
            .disabled(toolManager.activeItem == nil)
        
            Button(role: .destructive, action: { delete() }) {
                Label("Löschen", systemImage: "trash")
            }
            .tint(Color.red)
            .keyboardShortcut(.delete, modifiers: [])
            .disabled(subviewManager.showInspector)
            .disabled(toolManager.activeItem == nil)
        }
    }
}
