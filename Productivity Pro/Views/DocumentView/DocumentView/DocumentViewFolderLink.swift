//
//  FolderViewObjectLink.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.23.
//

import SwiftUI

extension DocumentView {
    
    @ViewBuilder
    func FolderLink(for object: ContentObject) -> some View {
        NavigationLink(destination: {
            DocumentView(
                parent: object.id.uuidString, title: object.title,
                contentObjects: contentObjects
            )
        }) {
            HStack {
                Label(object.title, systemImage: "folder.fill")
                Spacer()
                
                if object.isPinned {
                    Image(systemName: "pin")
                        .foregroundStyle(Color.accentColor)
                }
            }
        }
        .frame(height: 30)
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button(role: .destructive, action: {
                withAnimation(.bouncy) {
                    deleteFolder(object)
                }
            }) {
                Image(systemName: "trash.fill")
            }
        }
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
            Button("Umbenennen", systemImage: "pencil") {
                editFolder.toggle()
                selectedFolder = object
            }
            
            Button("Bewegen", systemImage: "folder") {
                
            }
        }
        
    }
    
    func deleteFolder(_ object: ContentObject) {
        var isDeleting: Bool = true
        object.inTrash = true
        
        var parents: [[String]] = [[object.id.uuidString]]
        var index: Int = 0
        
        
        while isDeleting {
            if index < parents.count {
                
                for p in parents[index] {
                    parents.append([])
                    
                    let filteredObjects = contentObjects.filter({
                        $0.parent == p
                    })
                    
                    for filteredObject in filteredObjects {
                        filteredObject.inTrash = true
                        
                        if parents.indices.contains(index + 1) {
                            parents[index + 1].append(
                                filteredObject.id.uuidString
                            )
                        }
                    }
                }
                
                index += 1
                
            } else {
                isDeleting = false
            }
        }
    }
    
}
