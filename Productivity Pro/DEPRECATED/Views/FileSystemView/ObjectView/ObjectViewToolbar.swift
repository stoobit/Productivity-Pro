//
//  FolderViewToolbar.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.23.
//

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
    
    @State private var showMachineLearningDemo: Bool = false
    
    var body: some ToolbarContent {
        // MARK: - Top Bar Leading
        ToolbarItemGroup(placement: .topBarLeading) {
            Button(action: { dismiss() }) {
                Label("Zurück", systemImage: "chevron.left")
            }
            .disabled(parent == "root")
            
            Menu("Optionen", systemImage: "line.3.horizontal.decrease") {
                Section("Anordnung") {
                    Picker("Sortieren nach", systemImage: "list.bullet", selection: $sortType) {
                        Text("Name").tag(SortingValue.title)
                        Text("Erstellt").tag(SortingValue.created)
                    }
                    .pickerStyle(.menu)
                    
                    Button(action: { isReverse.toggle() }) {
                        Label(
                            isReverse ? "Absteigend" : "Aufsteigend",
                            systemImage: isReverse ? "chevron.down" : "chevron.up"
                        )
                    }
                }
                
                Section("Darstellung") {
                    Toggle("Gruppieren", isOn: $typeSorting)
                    Toggle("Datum anzeigen", isOn: $showDate)
                }
                
                if parent == "root" {
                    Picker("Klasse \(grade)", selection: $grade) {
                        ForEach(5 ... 13, id: \.self) {
                            Text("\($0). Klasse")
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
        }
        
        ToolbarSpacer(placement: .topBarLeading)
        
        ToolbarItemGroup(placement: .topBarLeading) {
            NavigationLink(destination: {
                TrashView(
                    contentObjects: contentObjects,
                    filteredObjects: filteredObjects
                )
            }) {
                Label("Papierkorb", systemImage: "trash")
            }
            .tint(Color.red)
            .disabled(filteredObjects.isEmpty)
        }
        
        
        // MARK: - Primary Action
        if locale == "Deutsch" {
            ToolbarItemGroup(placement: .primaryAction) {
                Button("Bibliothek", systemImage: "books.vertical") {
                    libraryView.toggle()
                }
            }
        }
        
        ToolbarSpacer(placement: .primaryAction)
        ToolbarItemGroup(placement: .primaryAction) {
            Button("Ordner erstellen", systemImage: "folder.badge.plus") {
                addFolder = true
            }
            
            CreateNoteView(
                contentObjects: contentObjects,
                parent: parent, importFile: $importFile
            )
        }
    }
    
    var filteredObjects: [ContentObject] {
        contentObjects
            .filter { $0.inTrash }
            .sorted(by: {
                $0.title < $1.title
            })
            .sorted(by: {
                $0.grade < $1.grade
            })
    }
}
