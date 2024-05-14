//
//  FolderViewToolbar.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.23.
//

import Mixpanel
import SwiftUI

struct FolderViewToolbar: ToolbarContent {
    @Environment(\.dismiss) var dismiss
    @Environment(SubviewManager.self) var subviewManager
    
    var parent: String
    
    @AppStorage("ppgrade")
    var grade: Int = 5
    
    @AppStorage("ppsorttype")
    var sortType: SortingValue = .title
    
    @AppStorage("ppisreverse")
    var isReverse: Bool = false
    
    @AppStorage("ppsortbytype")
    var typeSorting: Bool = true
    
    @AppStorage("pp show date")
    var showDate: Bool = false
    
    @Binding var addFolder: Bool
    @Binding var importFile: Bool
    @Binding var libraryView: Bool
    
    var contentObjects: [ContentObject]
    let locale = Locale.current.localizedString(forIdentifier: "DE") ?? ""
    
    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            if locale == "Deutsch" {
                Button("Bibliothek", systemImage: "books.vertical") {
                    libraryView.toggle()
                        
                    #if DEBUG
                    #else
                    Mixpanel.mainInstance()
                        .track(event: "LIAP View", properties: [:])
                    #endif
                }
            }
            
            Button("Ordner erstellen", systemImage: "folder.badge.plus") {
                addFolder = true
            }
            
            CreateNoteView(
                contentObjects: contentObjects,
                parent: parent, importFile: $importFile
            )
        }
        
        ToolbarItemGroup(placement: .topBarLeading) {
            NavigationLink(destination: {
                TrashView(contentObjects: contentObjects)
            }) { Label("Papierkorb", systemImage: "trash") }
                .tint(Color.red)
            
            NavigationLink(destination: {
                SearchView(contentObjects: contentObjects)
            }) { Label("Suchen", systemImage: "magnifyingglass") }
            
            Button(action: { dismiss() }) {
                Label("Zurück", systemImage: "chevron.left")
            }
            .disabled(parent == "root")
            
            Menu(content: {
                Picker("", selection: $sortType) {
                    Text("Name").tag(SortingValue.title)
                    Text("Erstellt").tag(SortingValue.created)
                }
                    
                Button(action: { isReverse.toggle() }) {
                    Label(
                        isReverse ? "Absteigend" : "Aufsteigend",
                        systemImage: isReverse ? "chevron.down" : "chevron.up"
                    )
                }
                    
                Section {
                    Toggle("Gruppieren", isOn: $typeSorting)
                    Toggle("Datum anzeigen", isOn: $showDate)
                }
                    
                if parent == "root" {
                    Menu("Klasse") {
                        Section("Klasse") {
                            Picker("", selection: $grade) {
                                ForEach(5 ... 13, id: \.self) {
                                    Text("\($0). Klasse")
                                }
                            }
                            .labelsHidden()
                        }
                    }
                }
            }) {
                Label("Sortieren", systemImage: "list.bullet")
            }
        }
    }
    
    func image() -> String {
        if grade < 10 {
            return "0\(grade).circle"
        } else {
            return "\(grade).circle"
        }
    }
}
