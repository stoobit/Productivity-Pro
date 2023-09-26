//
//  DocumentView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.09.23.
//

import SwiftUI
import SwiftData

struct DocumentView: View {
    
    @Query(animation: .bouncy)
    var contentObjects: [ContentObject]
    
    @AppStorage("ppgrade") var grade: Int = 5
    
    @State var toolManager: ToolManager = ToolManager()
    @State var subviewManager: SubviewManager = SubviewManager()
    
    var body: some View {
        NavigationStack {
            FolderView(
                parent: "root",
                title: "Notizen",
                contentObjects: contentObjects,
                toolManager: toolManager,
                subviewManager: subviewManager
            )
            .overlay {
                Menu(content: {
                    Picker("", selection: $grade) {
                        ForEach(5...13, id: \.self) {
                            Text("Jgst \($0)")
                        }
                    }.labelsHidden()
                }) {
                    Text("Jgst \(grade)")
                        .foregroundStyle(.white)
                }
                .frame(width: 100, height: 50)
                .background(Color.accentColor)
                .clipShape(
                    UnevenRoundedRectangle(
                        topLeadingRadius: 16,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 0,
                        style: .continuous
                    )
                )
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .bottomTrailing
                )
            }
        }
    }
}

#Preview {
    ContentView()
}
