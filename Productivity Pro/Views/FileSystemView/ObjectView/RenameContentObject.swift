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
    @Bindable var object: ContentObject
    
    @AppStorage("ppgrade") var grade: Int = 5
    
    @Binding var isPresented: Bool
    @State var title: String = ""
    
    func body(content: Content) -> some View {
        content
            .alert(
                "\(object.type == COType.folder.rawValue ? "Ordner" : "Notiz") bearbeiten",
                isPresented: $isPresented
            ) {
                TextField("\(object.title)", text: $title)
                
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
                
                let filteredObjects = contentObjects
                    .filter({
                        $0.type == object.type &&
                        $0.parent == object.parent &&
                        $0.grade == grade &&
                        $0.inTrash == false
                    })
                    .map({ $0.title })
                
                
                while filteredObjects.contains(title) {
                    
                    title = "\(const) \(index)"
                    index += 1
                    
                }
                
                object.title = title
            }
            
            object.modified = Date()
            title = ""
        }
    }
    
}
