//
//  FolderViewFileLink.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 26.09.23.
//

import SwiftUI

struct DocumentViewFileLink: View {
    var contentObjects: [ContentObject]
    var object: ContentObject
    var swipeAction: Bool = true
    
    let delete: () -> Void
    
    @State var isMove: Bool = false
    @State var isRename: Bool = false
    
    var body: some View {
        NavigationLink(destination: {
            
        }) {
            ContentObjectLink(obj: object)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            if swipeAction {
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
        }
        .contextMenu {
            Section {
                Button("Umbenennen", systemImage: "pencil") {
                    isRename = true
                }
                
                Button("Bewegen", systemImage: "folder") {
                    isMove = true
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
                    delete()
                }
            }) {
                Label("Löschen", systemImage: "trash")
            }
        }
        .modifier(
            RenameContentObjectView(
                contentObjects: contentObjects,
                object: object,
                isPresented: $isRename, 
                parent: object.parent
            )
        )
        
    }
}
