//
//  DocumentPickerView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct DocumentPickerView: View {
    
    @AppStorage("recenturls") var recents: [URL] = []
    @AppStorage("pinnedurls") var pinned: [URL] = []
    
    @State var toolManager: ToolManager = ToolManager()
    @State var subviewManager: SubviewManager = SubviewManager()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    DocumentCreationView(
                        toolManger: toolManager, subviewManager: subviewManager
                    )
                    
                    DocumentBrowsingView(
                        toolManger: toolManager, subviewManager: subviewManager
                    )
                }
                
                Section("Angepinnt") {
                    ForEach(pinned, id: \.self) { pin in
                        let title = pin.lastPathComponent.string.dropLast(4)
                        
                        Label(title, systemImage: "pin")
                            .frame(height: 30)
                    }
                }
                
                Section("Letzte") {
                    ForEach(recents, id: \.self) { recent in
                        let title = recent.lastPathComponent.string.dropLast(4)
                        
                        Label(title, systemImage: "clock.arrow.circlepath")
                            .frame(height: 30)
                    }
                }
            }
            .environment(\.defaultMinListRowHeight, 10)
            .navigationTitle("Notizen")
        }
    }
}

#Preview {
    DocumentPickerView()
}
