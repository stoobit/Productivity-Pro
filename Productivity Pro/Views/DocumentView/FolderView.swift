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
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea(.all)
            
            List {
                ForEach(getObjects()) { object in
                    if object.type == .folder {
                        FolderLink(object.id.uuidString, object.title)
                    } else if object.type == .file {
                        
                    }
                }
            }
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
}

#Preview {
    DocumentView()
}
