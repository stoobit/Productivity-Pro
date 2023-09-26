//
//  FolderViewObjectLink.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.23.
//

import SwiftUI

extension FolderView {
    
    @ViewBuilder
    func FolderLink(_ p: String, _ t: String) -> some View {
        NavigationLink(destination: {
            FolderView(
                parent: p, title: t,
                contentObjects: contentObjects,
                toolManager: toolManager,
                subviewManager: subviewManager
            )
        }) {
            Label(t, systemImage: "folder.fill")
        }
        .frame(height: 30)
    }
    
}
