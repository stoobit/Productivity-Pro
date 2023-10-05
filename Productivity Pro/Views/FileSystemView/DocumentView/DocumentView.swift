//
//  FolderView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.09.23.
//

import SwiftUI
import SwiftData

struct DocumentView: View {
    @Environment(\.modelContext) var context
    
    var parent: String
    var title: String
    var contentObjects: [ContentObject]
    
    @AppStorage("ppsorttype") 
    var sortType: SortingValue = .title
    
    @AppStorage("ppisreverse")
    var isReverse: Bool = false
    
    @AppStorage("ppsortbytype")
    var typeSorting: Bool = true
    
    @AppStorage("ppgrade")
    var grade: Int = 5
    
    // MARK: Creation Values
    @State var addFolder: Bool = false
    @State var createNote: Bool = false
    @State var importFile: Bool = false

    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea(.all)
            
            List {
                Section {
                    ForEach(
                        getObjects(typeSorting == true ? .file : .all, isPinned: true)
                    ) { object in
                        ObjectLink(for: object)
                    }
                    
                    ForEach(
                        getObjects(typeSorting == true ? .folder : .none, isPinned: true)
                    ) { object in
                        ObjectLink(for: object)
                    }
                }
                
                Section {
                    ForEach(
                        getObjects(typeSorting == true ? .file : .all, isPinned: false)
                    ) { object in
                        ObjectLink(for: object)
                    }
                    
                    ForEach(
                        getObjects(typeSorting == true ? .folder : .none, isPinned: false)
                    ) { object in
                        ObjectLink(for: object)
                    }
                }
            }
            .animation(.bouncy, value: grade)
            .animation(.bouncy, value: sortType)
            .animation(.bouncy, value: typeSorting)
            .animation(.bouncy, value: isReverse)
            .scrollContentBackground(.hidden)
            .environment(\.defaultMinListRowHeight, 10)
            .navigationTitle(title)
            .navigationBarBackButtonHidden()
            .toolbarRole(.browser)
            .toolbar {
                FolderViewToolbar(
                    parent: parent,
                    addFolder: $addFolder,
                    importFile: $importFile,
                    createNote: $createNote,
                    contentObjects: contentObjects
                )
            }
            .navigationBarTitleDisplayMode(
                parent == "root" ? .large : .inline
            )
        }
        .modifier(
            AddFolderView(
                parent: parent,
                contentObjects: contentObjects, 
                isPresented: $addFolder
            )
        )
        .sheet(isPresented: $createNote) {
            CreateNoteView(
                contentObjects: contentObjects,
                isPresented: $createNote,
                parent: parent
            )
        }
        .fileImporter(
            isPresented: $importFile,
            allowedContentTypes: [.pro, .pronote, .probackup],
            allowsMultipleSelection: false
        ) { result in
            importFile(result: result)
        }
        
    }
    
    @ViewBuilder func ObjectLink(for object: ContentObject) -> some View {
        if object.type == .folder {
            DocumentViewFolderLink(
                contentObjects: contentObjects, object: object
            ) {
                deleteObject(object)
            }
        } else if object.type == .file {
            DocumentViewFileLink(
                contentObjects: contentObjects, object: object
            ) {
                deleteObject(object)
            }
        }
    }
    
}
