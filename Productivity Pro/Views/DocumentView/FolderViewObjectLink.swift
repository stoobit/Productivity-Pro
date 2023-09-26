//
//  FolderViewObjectLink.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.23.
//

import SwiftUI

extension FolderView {
    
    @ViewBuilder
    func FolderLink(parent: String, title: String) -> some View {
        NavigationLink(destination: {
            FolderView(
                parent: parent, title: title,
                contentObjects: contentObjects,
                toolManager: toolManager,
                subviewManager: subviewManager
            )
        }) {
            Label(title, systemImage: "folder.fill")
        }
        .frame(height: 30)
    }
    
}
