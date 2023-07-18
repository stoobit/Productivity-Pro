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
    
    @Binding var document: ProductivityProDocument
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    @State var text: String = ""
    
    let size: CGSize
    
    var body: some View {
        let layout = hsc == .regular ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout())
        
        NavigationStack {
            layout {
                
                TextEditor(text: $text)
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
                    .onAppear { viewDidAppear() }
                    .onChange(of: text) { value in
                        textDidChange(value)
                    }
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .topLeading
                    )
                    .padding(.leading, 2)
                
                Divider()
                
                ScrollView([.horizontal, .vertical], showsIndicators: false) {
                    
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
                
            }
            .toolbarRole(.browser)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                EditMarkdownToolbar(
                    toolManager: toolManager,
                    subviewManager: subviewManager
                )
            }
            
        }
    }
}
