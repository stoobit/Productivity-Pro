//
//  RTFEditorView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 13.12.23.
//

import SwiftUI

struct MDEditorView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(ToolManager.self) var toolManager

    @FocusState var isFocused: Bool
    let url = "https://www.stoobit.com/blog/markdown.html"
    
    @State var text: String = ""

    var body: some View {

        NavigationStack {
            TextEditor(text: $text)
                .fontDesign(.monospaced)
                .focused($isFocused)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Fertig") { dismiss() }
                    }

                    ToolbarItem(placement: .topBarLeading) {
                        Link("M", destination: URL(string: url)!)
                        .fontDesign(.rounded)
                        .fontWeight(.medium)
                        .font(.title2)
                    }
                }
                .onAppear {
                    if let string = toolManager.activeItem?.textField?.string {
                        text = string
                    }
                    
                    isFocused = true
                }
                .onChange(of: text, initial: false) {
                    toolManager.activeItem?.textField?.string = text
                }
        }
    }
}
