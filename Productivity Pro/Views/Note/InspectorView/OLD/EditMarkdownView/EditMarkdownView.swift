//
//  EditTextView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.03.23.
//

import SwiftUI

struct EditMarkdownView: View {
    
    @Environment(\.horizontalSizeClass) var hsc
    @FocusState var isFocused: Bool
    
    @Binding var document: Document
    
    @Bindable var toolManager: ToolManager
    @Bindable var subviewManager: SubviewManager
    
    @State var text: String = ""
    
    let size: CGSize
    
    var body: some View {
        NavigationStack {
            TextEditor(text: $text)
                .focused($isFocused)
                .textInputAutocapitalization(.never)
                .onAppear {
                    text = toolManager.selectedItem?.textField?.text ?? ""
                    isFocused = true
                }
                .onChange(of: text) { old, value in
                    let index = document.note.pages[
                        toolManager.selectedPage
                    ].items.firstIndex(where: {
                        $0.id == toolManager.selectedItem!.id
                    })!
                    
                    document.note.pages[
                        toolManager.selectedPage
                    ].items[index].textField!.text = value
                }
                .toolbarRole(.browser)
                
                .navigationTitle("Markdown")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Done") {
                            subviewManager.showTextEditor.toggle()
                        }
                        .keyboardShortcut(
                            .return, modifiers: [.command]
                        )
                    }
                }
        }
    }
}