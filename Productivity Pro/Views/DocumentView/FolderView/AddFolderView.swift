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
            title: title.isEmpty ? "Unbenannt" : title,
            type: .folder,
            parent: parent,
            created: Date(),
            grade: grade,
            document: nil
        )
        
        context.insert(folder)
        title = ""
    }
    
}
