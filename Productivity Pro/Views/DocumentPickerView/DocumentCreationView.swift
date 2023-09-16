//
//  DocumentCreationView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 13.09.23.
//

import SwiftUI

struct DocumentCreationView: View {
    
    @StateObject var toolManger: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    @State var document: Document = Document()
    @State var url: URL?
    @State var showCreationView: Bool = false

    var body: some View {
        Button(action: { showCreationView.toggle() }) {
            Label("Notiz erstellen", systemImage: "plus")
                .foregroundStyle(Color.accentColor)
        }
        .frame(height: 30)
        .sheet(isPresented: $showCreationView, onDismiss: {
            document = Document()
            url = nil
        }) {
            NewDocumentView(
                isPresented: $showCreationView,
                document: $document,
                url: $url,
                subviewManager: subviewManager,
                toolManager: toolManger
            )
        }
    }
}

#Preview {
    DocumentPickerView()
}
