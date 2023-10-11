//
//  FileSystemView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.09.23.
//

import SwiftUI
import SwiftData

struct FileSystemView: View {
    @Query(animation: .bouncy)
    var contentObjects: [ContentObject]
    
    @AppStorage("ppgrade") var grade: Int = 5
    
    var body: some View {
        NavigationStack {
            ObjectView(
                parent: "root",title: "Notizen",
                contentObjects: contentObjects
            )
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
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
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
