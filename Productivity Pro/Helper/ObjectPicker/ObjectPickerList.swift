//
//  ObjectPickerList.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 28.09.23.
//

import SwiftUI

struct ObjectPickerList: View {
    @Environment(\.dismiss) var dismiss
    
    var contentObjects: [ContentObject]
    @Binding var isPresented: Bool
    @Binding var selectedObject: String
    
    var parent: String
    var title: String
    var id: UUID?
    
    var type: COType
    
    var body: some View {
        if objects.isEmpty {
            ContentUnavailableView(
                parent == "root" ? "Du hast noch keine Notizen erstellt." : "Dieser Ordner ist leer.",
                systemImage: parent == "root" ? "doc" : "folder"
            )
            .listRowBackground(Color.clear)
            
        } else {
            List {
                ForEach(objects) { object in
                    if object.type == COType.folder.rawValue {
                        
                        NavigationLink(destination: {
                            ObjectPickerList(
                                contentObjects: contentObjects,
                                isPresented: $isPresented,
                                selectedObject: $selectedObject,
                                parent: object.id.uuidString,
                                title: object.title,
                                id: id,
                                type: type
                            )
                        }) {
                            ContentObjectLink(obj: object)
                        }
                        .disabled(id == object.id)
                        
                    } else if object.type == COType.file.rawValue {
                        
                        Button(action: {
                            selectedObject = object.id.uuidString
                            isPresented.toggle()
                        }) {
                            ContentObjectLink(obj: object)
                        }
                        .disabled(type == .folder)
                        
                    }
                }
            }
            .scrollContentBackground(.visible)
            .navigationBarBackButtonHidden()
            .environment(\.defaultMinListRowHeight, 10)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if parent != "root" {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.left")
                                .fontWeight(.semibold)
                        }
                    }
                }
                
                if type == .folder {
                    ToolbarItem(placement: .confirmationAction) {
                        Button(action: {
                            selectedObject = parent
                            isPresented = false
                        }) {
                            Text("Auswählen")
                        }
                    }
                }
            }
            
        }
    }
    
    var objects: [ContentObject] {
        return contentObjects.filter {
            $0.parent == parent
        }.sorted(by: { $0.title < $1.title })
    }
    
}
