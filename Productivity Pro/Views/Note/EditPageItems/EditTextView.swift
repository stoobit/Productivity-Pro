//
//  EditTextView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.03.23.
//

import SwiftUI
import MarkdownUI

struct EditTextView: View {
    
    @Environment(\.horizontalSizeClass) var hsc
    @FocusState var isFocused: Bool
    
    @Binding var document: ProductivityProDocument
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
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
                .onChange(of: text) { value in
                    let index = document.document.note.pages[
                        toolManager.selectedPage
                    ].items.firstIndex(where: {
                        $0.id == toolManager.selectedItem!.id
                    })!
                    
                    document.document.note.pages[
                        toolManager.selectedPage
                    ].items[index].textField!.text = value
                    
                }
                .toolbarRole(.navigationStack)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationTitle("Markdown")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            subviewManager.showTextEditor.toggle()
                        }
                        .keyboardShortcut(
                            .return, modifiers: [.command]
                        )
                    }
                }
                .sheet(isPresented: $subviewManager.markdownHelp) {
                    MarkdownInfoView(isPresented: $subviewManager.markdownHelp)
                }
        }
    }
}
