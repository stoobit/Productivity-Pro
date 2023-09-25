//
//  FolderViewToolbar.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.23.
//

import SwiftUI

struct FolderViewToolbar: ToolbarContent {
    var parent: String
    
    @AppStorage("ppgrade") var grade: Int = 5
    
    @AppStorage("ppsorttype")
    var sortType: SortingValue = .title
    
    @AppStorage("ppisreverse")
    var isReverse: Bool = false
    
    var body: some ToolbarContent {
        
        ToolbarItemGroup(placement: .topBarTrailing) {
            Picker("", selection: $grade) {
                ForEach(5...13, id: \.self) {
                    Text("Jgst \($0)")
                }
            }
                .labelsHidden()
            
            Button("Ordner erstellen", systemImage: "folder.badge.plus") {
                
            }
        }
        
        ToolbarItem(placement: .confirmationAction) {
            Button(action: {}) {
                Image(systemName: "plus")
            }
        }
        
        ToolbarItemGroup(placement: .topBarLeading) {
            NavigationLink(destination: {
                
            }) { Image(systemName: "magnifyingglass") }
            
            Menu(content: {
                Picker("", selection: $sortType) {
                    Text("Name").tag(SortingValue.title)
                    Text("Erstellt").tag(SortingValue.created)
                    Text("Geändert").tag(SortingValue.modified)
                }
                
                Button(action: { isReverse.toggle() }) {
                    Label(
                        isReverse ? "Absteigend" : "Aufsteigend",
                        systemImage: isReverse ? "chevron.down" :"chevron.up"
                    )
                }
                
            }) {
                Image(systemName: "list.bullet")
            }
        }
        
    }
}

#Preview {
    DocumentView()
}
