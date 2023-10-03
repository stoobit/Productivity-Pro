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
    
    var type: ContentObjectType

    var body: some View {
        List {
            if objects.isEmpty {
                ContentUnavailableView(
                    parent == "root" ? "" : "Dieser Ordner ist leer.",
                    systemImage: parent == "root" ? "" : "folder"
                )
                .listRowBackground(Color.clear)
                
            } else {
                
                ForEach(objects) { object in
                    if object.type == .folder {
                        
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
                        
                    } else if object.type == .file {
                        
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
        }
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
    
    var objects: [ContentObject] {
        return contentObjects.filter {
            $0.parent == parent
        }.sorted(by: { $0.title < $1.title })
    }
    
}
