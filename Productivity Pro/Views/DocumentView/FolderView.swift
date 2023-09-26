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
    
    @AppStorage("ppgrade")
    var grade: Int = 5

    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea(.all)
            
            List {
                Section {
                    ForEach(getObjects(isPinned: true)) { object in
                        ObjectLink(for: object)
                    }
                }
                
                Section {
                    ForEach(getObjects(isPinned: false)) { object in
                        ObjectLink(for: object)
                    }
                }
            }
            .animation(.bouncy, value: grade)
            .scrollContentBackground(.hidden)
            .environment(\.defaultMinListRowHeight, 10)
            .navigationTitle(title)
            .navigationBarBackButtonHidden()
            .toolbarRole(.browser)
            .toolbar {
                FolderViewToolbar(parent: parent)
            }
            .navigationBarTitleDisplayMode(
                parent == "root" ? .large : .inline
            )
        }
    }
    
    @ViewBuilder func ObjectLink(for object: ContentObject) -> some View {
        if object.type == .folder {
            FolderLink(for: object)
        } else if object.type == .file {
            FileLink(for: object)
        }
    }
    
}

#Preview {
    DocumentView()
}
