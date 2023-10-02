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
                Text("Dieser Ordner ist leer.")
                    .foregroundStyle(Color.secondary)
                    .frame(height: 30)
                
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
                            Label(object.title, systemImage: "folder.fill")
                                .frame(height: 30)
                        }
                        .disabled(id == object.id)
                        .frame(height: 30)
                        
                    } else if object.type == .file {
                        
                        Button(action: {
                            selectedObject = object.id.uuidString
                            isPresented.toggle()
                        }) {
                            Label(object.title, systemImage: "doc.fill")
                        }
                        .frame(height: 30)
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
                    Button(action: { move() }) {
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
    
    func move() {
        selectedObject = parent
        isPresented = false
    }
    
}
