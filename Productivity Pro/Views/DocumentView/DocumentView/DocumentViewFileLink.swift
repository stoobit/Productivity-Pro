//
//  FolderViewFileLink.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 26.09.23.
//

import SwiftUI

extension DocumentView {
    
    @ViewBuilder
    func FileLink(for object: ContentObject) -> some View {
            NavigationLink(destination: {
                
                
                
            }) {
                HStack {
                    Label(object.title, systemImage: "doc.fill")
                    Spacer()
                    
                    if object.isPinned {
                        Image(systemName: "pin")
                            .foregroundStyle(Color.accentColor)
                    }
                }
            }
            .frame(height: 30)
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                Button(role: .destructive, action: {
                    withAnimation(.bouncy) {
                        object.isPinned.toggle()
                    }
                }) {
                    Image(systemName: !object.isPinned ? "pin.fill" : "pin.slash.fill"
                    )
                }
                .tint(Color.accentColor)
            }
            .contextMenu {
                Section {
                    Button("Umbenennen", systemImage: "pencil") {
                        renameContentObject.toggle()
                        selectedObject = object
                    }
                    
                    Button("Bewegen", systemImage: "folder") {
                        selectedObject = object
                        moveContentObject = true
                    }
                }
                
                Section {
                    Button(action: {
                       
                    }) {
                        Label("Teilen", systemImage: "square.and.arrow.up")
                    }
                }
                
                Button(role: .destructive, action: {
                    withAnimation(.bouncy) {
                        deleteObject(object)
                    }
                }) {
                    Label("Löschen", systemImage: "trash")
                }
            }
            
        
    }
    
}
