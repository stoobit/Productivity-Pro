//
//  FolderView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.09.23.
//

import SwiftUI
import SwiftData

struct FolderView: View {
    @Environment(\.modelContext) var context
    
    var parent: String
    var title: String
    var contentObjects: [ContentObject]
    
    @Bindable var toolManager: ToolManager
    @Bindable var subviewManager: SubviewManager
    
    @State var isAddFolder: Bool = false
    @State var folderTitle: String = ""
    @State var searchText: String = ""
    
    @AppStorage("ppsorttype") 
    var sortType: SortingValue = .title
    
    @AppStorage("ppisreverse")
    var isReverse: Bool = false

    var body: some View {
        List {
            ForEach(contentObjects) { object in
                if object.type == .folder {
                    
                } else if object.type == .file {
                    
                }
            }
        }
        .scrollContentBackground(.hidden)
        .environment(\.defaultMinListRowHeight, 30)
        .navigationTitle(title)
        .toolbarRole(.browser)
        .navigationBarTitleDisplayMode(
            parent == "root" ? .large : .inline
        )
        .toolbar {
            FolderViewToolbar(parent: parent)
        }
        .alert("Ordner hinzufügen", isPresented: $isAddFolder) {
            TextField("Name", text: $folderTitle)
            Button("Erstellen", action: addFolder)
            Button("Abbrechen", role: .cancel, action: {
                isAddFolder.toggle()
                folderTitle = ""
            })
        }
    }
    
    func addFolder() {
        withAnimation(.bouncy) {
         
            folderTitle = ""
        }
    }
    
//    func getFolders() -> [Folder] {
//        if isReverse == false {
//            switch sortType {
//            case .created:
//                return folders.sorted(by: { $0.date < $1.date })
//            case .title:
//                return folders.sorted(by: { $0.title < $1.title })
//            case .changed:
//                return folders.sorted(by: { $0.dateChanged < $1.dateChanged })
//            }
//        } else {
//            switch sortType {
//            case .created:
//                return folders.sorted(by: { $0.date > $1.date })
//            case .title:
//                return folders.sorted(by: { $0.title > $1.title })
//            case .changed:
//                return folders.sorted(by: { $0.dateChanged > $1.dateChanged })
//            }
//        }
//    }
}

#Preview {
    DocumentView()
}
