//
//  DocumentView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.09.23.
//

import SwiftUI
import SwiftData

struct DocumentView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State var isAddFolder: Bool = false
    @State var folderTitle: String = ""
    
    @AppStorage("ppsorttype") var sortType: SortType = .title
    @AppStorage("ppisreverse") var isReverse: Bool = false
    
    @Query(animation: .bouncy) var folders: [TopLevelFolder]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea(.all)
                
                List {
                    ForEach(getFolders()) { folder in
                        NavigationLink(destination: {
                            FolderView()
                        }) {
                            Label(folder.title, systemImage: "folder.fill")
                                .frame(height: 30)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .environment(\.defaultMinListRowHeight, 30)
            }
            .alert("Ordner hinzufügen", isPresented: $isAddFolder) {
                TextField("Name", text: $folderTitle)
                Button("Erstellen", action: addFolder)
                Button("Abbrechen", role: .cancel, action: {
                    isAddFolder.toggle()
                    folderTitle = ""
                })
            }
            .navigationTitle("Notizen")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { isAddFolder.toggle() }) {
                        Image(systemName: "folder.badge.plus")
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Menu(content: {
                        Picker("", selection: $sortType) {
                            Text("Name").tag(SortType.title)
                            Text("Erstellt").tag(SortType.created)
                            Text("Geändert").tag(SortType.changed)
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
    }
    
    func addFolder() {
        withAnimation(.bouncy) {
            let folder = TopLevelFolder(title: folderTitle, topLevel: true, date: Date())
            folderTitle = ""
            
            context.insert(folder)
            try? context.save()
        }
    }
    
    func getFolders() -> [TopLevelFolder] {
        if isReverse == false {
            switch sortType {
            case .created:
                return folders.sorted(by: { $0.date < $1.date })
            case .title:
                return folders.sorted(by: { $0.title < $1.title })
            case .changed:
                return folders.sorted(by: { $0.dateChanged < $1.dateChanged })
            }
        } else {
            switch sortType {
            case .created:
                return folders.sorted(by: { $0.date > $1.date })
            case .title:
                return folders.sorted(by: { $0.title > $1.title })
            case .changed:
                return folders.sorted(by: { $0.dateChanged > $1.dateChanged })
            }
        }
    }
    
}

enum SortType: String {
    case created = "created"
    case title = "title"
    case changed = "changed"
}

#Preview {
    DocumentView()
}
