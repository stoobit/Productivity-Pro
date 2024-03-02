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
                .focused($isFocused)
                .fontDesign(.monospaced)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Fertig") {
                            toolManager.activeItem?.textField?.string = text
                            dismiss()
                        }
                    }

                    ToolbarItem(placement: .topBarLeading) {
                        Link("M", destination: URL(string: url)!)
                            .fontDesign(.rounded)
                            .fontWeight(.medium)
                            .font(.title2)
                    }
                }
                .onAppear {
                    isFocused = true
                }
        }
    }
}
