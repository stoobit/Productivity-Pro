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
    
    @Binding var selectedObject: ContentObject?
    @Binding var isPresented: Bool
    
    var parent: String
    var title: String

    var body: some View {
        Group {
            if objects(with: parent).isEmpty {
                #warning("Filter for GRADES")
                Form {
                    Text("Dieser Ordner ist leer.")
                        .foregroundStyle(Color.secondary)
                        .frame(height: 30)
                }
                
            } else {
                
                List(objects(with: parent)) { object in
                    
                    if object.type == .folder {
                        
                        NavigationLink(destination: {
                            
                            ObjectPickerList(
                                contentObjects: contentObjects,
                                selectedObject: $selectedObject,
                                isPresented: $isPresented,
                                parent: object.id.uuidString,
                                title: object.title
                            )
                            
                        }) {
                            Label(object.title, systemImage: "folder.fill")
                                .frame(height: 30)
                        }
                        .disabled(selectedObject?.id == object.id)
                        .frame(height: 30)
                        
                    } else if object.type == .file {
                        
                        Button(action: {}) {
                            Label(object.title, systemImage: "doc.fill")
                        }
                        .frame(height: 30)
                        .disabled(true)
                        
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
            
            ToolbarItem(placement: .confirmationAction) {
                Button(action: { move() }) {
                    Text("Auswählen")
                }
            }
        }
            
    }
    
    func objects(with parent: String) -> [ContentObject] {
        return contentObjects.filter {
            $0.parent == parent 
        }
    }
    
    func move() {
        withAnimation(.bouncy) {
            selectedObject?.parent = parent
            selectedObject = nil
            isPresented = false
        }
    }
    
}
