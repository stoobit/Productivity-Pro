//
//  FolderViewToolbar.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.23.
//

import SwiftUI

struct FolderViewToolbar: ToolbarContent {
    @Environment(\.dismiss) var dismiss
    var parent: String
    
    @AppStorage("ppgrade") var grade: Int = 5
    
    @AppStorage("ppsorttype")
    var sortType: SortingValue = .title
    
    @AppStorage("ppisreverse")
    var isReverse: Bool = false
    
    var body: some ToolbarContent {
        
        ToolbarItemGroup(placement: .topBarTrailing) {
//            Picker("", selection: $grade) {
//                ForEach(5...13, id: \.self) {
//                    Text("Jgst \($0)")
//                }
//            }
//            .labelsHidden()
//            .disabled(parent != "root")
            
            Menu(content: {
                Button("Datei importieren", systemImage: "doc") {
                    
                }
                
                Button("Backup importieren", systemImage: "externaldrive.badge.timemachine") {
                    
                }
            }) {
                Label("Importieren", systemImage: "square.and.arrow.down")
            }
            
            Button("Ordner erstellen", systemImage: "folder.badge.plus") {
                
            }
            
            Button("Datei erstellen", systemImage: "plus") {
                
            }
        }
        
        ToolbarItemGroup(placement: .topBarLeading) {
            NavigationLink(destination: {
                
            }) { Image(systemName: "magnifyingglass") }
            
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
            }
            .disabled(parent == "root")
            
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
