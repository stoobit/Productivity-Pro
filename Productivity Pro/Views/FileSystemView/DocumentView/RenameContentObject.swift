//
//  RenameFolderView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 28.09.23.
//

import SwiftUI

struct RenameContentObjectView: ViewModifier {
    @Environment(\.modelContext) var context
    
    var contentObjects: [ContentObject]
    var object: ContentObject?
    
    @State var title: String = ""
    @Binding var isPresented: Bool
    
    func body(content: Content) -> some View {
        content
            .alert(
                "\(object?.type == .folder ? "Ordner" : "Notiz") bearbeiten",
                isPresented: $isPresented
            ) {
                TextField("\(object?.title ?? "")", text: $title)
                
                Button("Abbrechen", role: .cancel) {
                    title = ""
                    isPresented.toggle()
                }
                
                Button("Umbenennen") { editFolder() }
            }
    }
    
    func editFolder() {
        withAnimation(.bouncy) {
            if title.trimmingCharacters(in: .whitespaces) != "" {
                let const: String = title
                var index: Int = 1
                
                
                while contentObjects
                    .filter({ $0.type == .folder && $0.inTrash == false })
                    .map({ $0.title }).contains(title) {
                    
                    title = "\(const) \(index)"
                    index += 1
                    
                }
                
                object?.title = title
            }
            
            title = ""
        }
    }
    
}