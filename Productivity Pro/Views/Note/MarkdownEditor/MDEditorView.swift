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
    
    @State var tutorial: Bool = false
    @FocusState var isFocused: Bool

    var body: some View {
        @Bindable var textField = toolManager.activeItem!.textField!

        NavigationStack {
            TextEditor(text: $textField.string)
                .focused($isFocused)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Fertig") { dismiss() }
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Markdown", systemImage: "puzzlepiece.fill") {
                            tutorial.toggle()
                        }
                    }
                }
                .sheet(isPresented: $tutorial) {
                    MarkdownTutorialView()
                }
                .onAppear {
                    isFocused = true
                }
        }
    }
}
