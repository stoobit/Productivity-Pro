//
//  DocumentView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.09.23.
//

import SwiftUI
import SwiftData

struct DocumentView: View {
    var body: some View {
        NavigationStack {
            FolderView(
                parent: "root", title: "Notizen"
            )
        }
    }
}

#Preview {
    DocumentView()
}
