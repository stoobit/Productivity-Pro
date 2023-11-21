//
//  RTFEditorView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.11.23.
//

import SwiftUI
import RichTextKit

struct RTFEditorView: View {
    @Environment(ToolManager.self) var toolManager
    
    @StateObject var context: RichTextContext = RichTextContext()
    @State var nsString: NSAttributedString = .init()
    
    @AppStorage("defaultFont")
    private var defaultFont: String = "Avenir Next"
    
    @AppStorage("defaultFontSize")
    private var defaultFontSize: Double = 12
    
    var body: some View {
        NavigationStack {
            RichTextEditor(text: $nsString, context: context)
            .toolbar { RTFEditorToolbar(context: context) }
            .toolbarBackground(.visible, for: .navigationBar)
            .onChange(of: nsString) {
                toolManager.activeItem?.textField?.nsAttributedString = nsString.data()
                
                if nsString.string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    context.fontName = defaultFont
                    context.fontSize = defaultFontSize
                }
            }
            .onAppear {
                if let data = toolManager.activeItem?.textField?.nsAttributedString {
                    if let string = NSAttributedString(data: data) {
                        context.setAttributedString(to: string)
                    }
                }
            }
            
        }
    }
}

#Preview {
    RTFEditorView()
}
