//
//  AddFolderView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 27.09.23.
//

import SwiftUI

struct AddFolderView: ViewModifier {
    @Environment(\.modelContext) var context
    var parent: String
    var contentObjects: [ContentObject]
    
    @AppStorage("ppgrade") var grade: Int = 5
    
    @State var title: String = ""
    @Binding var isPresented: Bool
    
    func body(content: Content) -> some View {
        content
            .alert("Ordner erstellen", isPresented: $isPresented) {
                TextField("Unbenannt", text: $title)
                
                Button("Abbrechen", role: .cancel) {
                    title = ""
                    isPresented.toggle()
                }
                
                Button("Hinzufügen") { addFolder() }
            }
    }
    
    func addFolder() {
        let folder = ContentObject(
            id: UUID(),
            title: "",
            type: .folder,
            parent: parent,
            created: Date(),
            grade: grade,
            document: nil
        )
        
        if title.trimmingCharacters(in: .whitespaces) != "" {
            let const: String = title
            var index: Int = 1
            
            
            while contentObjects
                .filter({ $0.type == .folder && $0.inTrash == false })
                .map({ $0.title }).contains(title) {
                
                title = "\(const) \(index)"
                index += 1
                
            }
            
            folder.title = title
        }
        
        context.insert(folder)
        title = ""
    }
    
}
