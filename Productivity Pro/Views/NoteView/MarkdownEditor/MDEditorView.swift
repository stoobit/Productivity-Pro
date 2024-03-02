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

    var body: some View {
        @Bindable var item = toolManager.activeItem!.textField!

        NavigationStack {
            TextEditor(text: $item.string)
                .focused($isFocused)
                .fontDesign(.monospaced)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Fertig") {
                            toolManager.update -= 1
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
