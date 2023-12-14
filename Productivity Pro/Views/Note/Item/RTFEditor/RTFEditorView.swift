//
//  RTFEditorView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 13.12.23.
//

import SwiftUI
import RichTextKit

struct RTFEditorView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(ToolManager.self) var toolManager
    
    @StateObject var context: RichTextContext = .init()
    @State var text: NSAttributedString = NSAttributedString(
        string: "%$=00â"
    )
    
    var body: some View {
        NavigationStack {
            if text.string != "%$=00â" {
                RichTextEditor(text: $text, context: context)
                    .background(backgroundColor().ignoresSafeArea(.all, edges: .all))
                    .toolbarBackground(.visible, for: .navigationBar)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Fertig") { dismiss() }
                        }
                        
                        RTFEditorToolbar(context: context, text: $text)
                    }
            }
        }
        .onAppear() {
            loadString()
        }
        .onChange(of: text) {
            textChange()
        }
    }
    
    func loadString() {
        let data = toolManager.activeItem!.textField!.nsAttributedString
        let string = NSAttributedString(data: data)!
        
        text = string
    }
    
    func textChange() {
        toolManager.activeItem?.textField?.nsAttributedString = text.data()
    }
    
    func backgroundColor() -> Color {
        if toolManager.activeItem?.textField?.fill == true {
            guard let color = toolManager.activeItem?.textField?.fillColor else {
                return .clear
            }
            
            return Color(data: color)
        } else {
            guard let color = toolManager.activePage?.color else {
                return .clear
            }
            
            return Color(color)
        }
    }
}