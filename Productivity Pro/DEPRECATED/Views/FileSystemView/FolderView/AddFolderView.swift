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
        withAnimation(.smooth(duration: 0.2)) {
            let folder = ContentObject(
                id: UUID(),
                title: "",
                type: .folder,
                parent: parent,
                created: Date(),
                grade: grade
            )
            
            if title.trimmingCharacters(in: .whitespaces).isEmpty {
                title = String(localized: "Unbenannt")
            }
            
            let const: String = title
            var index: Int = 1
            
            let filteredObjects = contentObjects
                .filter {
                    $0.type == COType.folder.rawValue &&
                        $0.parent == parent &&
                        $0.grade == grade &&
                        $0.inTrash == false
                }
                .map { $0.title }
            
            while filteredObjects.contains(title) {
                title = "\(const) \(index)"
                index += 1
            }
            
            folder.title = title
            
            context.insert(folder)
            title = ""
        }
    }
}
