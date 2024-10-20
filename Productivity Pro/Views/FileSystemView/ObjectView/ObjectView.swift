//
//  FolderView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.09.23.
//

import SwiftData
import SwiftUI

struct ObjectView: View {
    @Environment(ToolManager.self) var toolManager
    @Environment(SubviewManager.self) var subviewManager
    
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
    
    @AppStorage("pp show date")
    var showDate: Bool = false
    
    @State var addFolder: Bool = false
    @State var createNote: Bool = false
    @State var importFile: Bool = false
    
    @State var libraryView: Bool = false

    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea(.all)
            
            List {
                Section {
                    ForEach(
                        getObjects(typeSorting == true ? .vocabulary : .all, isPinned: true)
                    ) { object in
                        ObjectLink(for: object)
                    }
                    
                    ForEach(
                        getObjects(typeSorting == true ? .file : .none, isPinned: true)
                    ) { object in
                        ObjectLink(for: object)
                    }
                    
                    ForEach(
                        getObjects(typeSorting == true ? .book : .none, isPinned: true)
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
                        getObjects(typeSorting == true ? .vocabulary : .all, isPinned: false)
                    ) { object in
                        ObjectLink(for: object)
                    }
                    
                    ForEach(
                        getObjects(typeSorting == true ? .file : .none, isPinned: false)
                    ) { object in
                        ObjectLink(for: object)
                    }
                    
                    ForEach(
                        getObjects(typeSorting == true ? .book : .none, isPinned: false)
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
            .animation(.smooth(duration: 0.2), value: grade)
            .animation(.smooth(duration: 0.2), value: sortType)
            .animation(.smooth(duration: 0.2), value: typeSorting)
            .animation(.smooth(duration: 0.2), value: showDate)
            .animation(.smooth(duration: 0.2), value: isReverse)
            .scrollContentBackground(.hidden)
            .environment(\.defaultMinListRowHeight, 10)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbarRole(.browser)
            .toolbar {
                FolderViewToolbar(
                    parent: parent, addFolder: $addFolder,
                    importFile: $importFile, libraryView: $libraryView,
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
        .fileImporter(
            isPresented: $importFile,
            allowedContentTypes: [.pro, .pronote, .pdf],
            allowsMultipleSelection: true
        ) { result in
            withAnimation(.smooth(duration: 0.2)) {
                importFile(result: result)
            }
        }
        .sheet(isPresented: $libraryView) {
            LIAPView(parent: parent)
        }
    }
    
    @ViewBuilder func ObjectLink(for object: ContentObject) -> some View {
        if object.type == COType.folder.rawValue {
            ObjectViewFolderLink(
                contentObjects: contentObjects, object: object
            ) {
                deleteObject(object)
            }
        } else if object.type == COType.file.rawValue {
            ObjectViewFileLink(
                contentObjects: contentObjects, object: object
            ) {
                deleteObject(object)
            }
        } else if object.type == COType.vocabulary.rawValue {
            ObjectViewVocabularyLink(
                contentObjects: contentObjects, object: object
            ) {
                context.delete(object)
            }
        } else {
            ObjectViewBookLink(
                contentObjects: contentObjects, object: object
            ) {
                context.delete(object)
            }
        }
    }
}
