//
//  FolderView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.09.23.
//

import SwiftUI
import SwiftData

struct FolderView: View {
    var parent: String
    var title: String
    
    @Environment(\.modelContext) var context
    
    @Query(animation: .bouncy)
    var contentObjects: [ContentObject]
    
    @State var isAddFolder: Bool = false
    @State var folderTitle: String = ""
    
    @AppStorage("ppsorttype") 
    var sortType: SortingValue = .title
    
    @AppStorage("ppisreverse")
    var isReverse: Bool = false
    
    @State var searchText: String = ""

    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea(.all)
            
            List {
                ForEach(contentObjects) { folder in
                    NavigationLink(destination: {
                       
                    }) {
                        
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
        }
        .edgesIgnoringSafeArea(.all)
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
