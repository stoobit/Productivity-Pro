//
//  FolderViewObjectLink.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.23.
//

import SwiftUI

extension FolderView {
    
    @ViewBuilder
    func FolderLink(for object: ContentObject) -> some View {
        NavigationLink(destination: {
            FolderView(
                parent: object.id.uuidString, title: object.title,
                contentObjects: contentObjects,
                toolManager: toolManager,
                subviewManager: subviewManager
            )
        }) {
            HStack {
                Label(object.title, systemImage: "folder.fill")
                Spacer()
                
                if object.isPinned {
                    Image(systemName: "pin")
                }
            }
        }
        .frame(height: 30)
    }
    
}
