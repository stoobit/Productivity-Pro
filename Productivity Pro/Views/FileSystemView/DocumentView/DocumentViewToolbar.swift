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
    
    @AppStorage("ppsorttype")
    var sortType: SortingValue = .title
    
    @AppStorage("ppisreverse")
    var isReverse: Bool = false
    
    @AppStorage("ppsortbytype")
    var typeSorting: Bool = true
    
    @Binding var addFolder: Bool
    @Binding var importFile: Bool
    
    @Binding var createNote: Bool
    
    var body: some ToolbarContent {
        
        ToolbarItemGroup(placement: .topBarTrailing) {
            Menu(content: {
                Button("Datei importieren", systemImage: "doc") {
                    importFile.toggle()
                }
                
                Button("Backup importieren", systemImage: "externaldrive.badge.timemachine") {
                    
                }
            }) {
                Label("Importieren", systemImage: "square.and.arrow.down")
            }
            
            Button("Ordner erstellen", systemImage: "folder.badge.plus") {
                addFolder = true
            }
            
            Button("Notiz erstellen", systemImage: "plus") {
                createNote.toggle()
            }
        }
        
        ToolbarItemGroup(placement: .topBarLeading) {
            NavigationLink(destination: {
                
            }) { Label("Papierkorb", systemImage: "trash") }
                .tint(Color.red)
            
            NavigationLink(destination: {
                SearchView()
            }) { Label("Suchen", systemImage: "magnifyingglass") }
            
            Button(action: { dismiss() }) {
                Label("Zurück", systemImage: "chevron.left")
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
                
                Section {
                    Toggle("Gruppieren", isOn: $typeSorting)
                }
                
            }) {
                Label("Sortieren", systemImage: "list.bullet")
            }
        }
        
    }
}