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

    var body: some View {
        ZStack {
            HStack {
                Button(action: { paste() }) {
                    ClipboardButton(image: "doc.on.clipboard")
                }
                .disabled(subviewManager.showInspector)
                .alert(
                    "Es konnte kein Objekt eingefügt werden.", isPresented: $alert
                ) {
                    Button("Ok") { alert.toggle() }
                }
            
                Button(action: { copy() }) {
                    ClipboardButton(image: "doc.on.doc")
                }
                .disabled(subviewManager.showInspector)
                .disabled(toolManager.activeItem == nil)
            
                Button(action: { duplicate() }) {
                    ClipboardButton(image: "plus.square.on.square")
                }
                .disabled(subviewManager.showInspector)
                .disabled(toolManager.activeItem == nil)
            
                Button(role: .destructive, action: { cut() }) {
                    ClipboardButton(image: "scissors")
                }
                .disabled(subviewManager.showInspector)
                .disabled(toolManager.activeItem == nil)
            
                Button(role: .destructive, action: { delete() }) {
                    ClipboardButton(image: "trash")
                }
                .disabled(subviewManager.showInspector)
                .disabled(toolManager.activeItem == nil)
            }
            .padding(5)
            .background {
                RoundedRectangle(cornerRadius: 14)
                    .foregroundStyle(.thinMaterial)
            }
            .offset(y: toolManager.pencilKit ? 100 : 0)
            .animation(.bouncy, value: toolManager.pencilKit)
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
