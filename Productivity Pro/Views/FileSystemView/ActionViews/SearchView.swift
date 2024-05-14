//
//  SearchView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.09.23.
//

import SwiftUI
import SwiftData

struct SearchView: View {
    var contentObjects: [ContentObject]
    @State var searchText: String = ""
    
    var body: some View {
        List {
            ForEach(searchResults) { object in
                ObjectViewFileLink(
                    contentObjects: contentObjects,
                    object: object,
                    swipeAction: false
                ) {
                    object.inTrash = true
                }
            }
        }
        .scrollContentBackground(.hidden)
        .animation(.smooth(duration: 0.2), value: searchResults)
        .environment(\.defaultMinListRowHeight, 30)
        .navigationTitle("Suchen")
        .navigationBarTitleDisplayMode(.large)
        .searchable(text: $searchText, placement: .toolbar) {
            if searchText.isEmpty == false {
                ForEach(searchKeys, id: \.self) { result in
                    Text(result)
                        .searchCompletion(result)
                }
            }
        }
        .overlay {
            Group {
                if searchResults.isEmpty && searchText.isEmpty {
                    ContentUnavailableView(
                        "Du hast noch keine Notizen erstellt.",
                        systemImage: "doc.fill"
                    )
                } else if searchResults.isEmpty && !searchText.isEmpty {
                    ContentUnavailableView(
                        "Es wurden keine Notizen gefunden.",
                        systemImage: "magnifyingglass"
                    )
                }
            }
        }
        .background {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea(.all)
        }
    }
    
    var searchKeys: [String] {
        let searchKeys = searchResults.map({ $0.title })
        let keySet = Set(searchKeys)
        
        return Array(keySet).sorted(by: { $0 < $1 })
    }
    
    var searchResults: [ContentObject] {
        if searchText.isEmpty {
            return contentObjects
                .filter{
                    $0.type == COType.file.rawValue && $0.inTrash == false
                }
                .sorted(by: { $0.title < $1.title })
            
        } else {
            return contentObjects
                .filter {
                    $0.type == COType.file.rawValue && 
                    $0.inTrash == false
                }
                .filter({
                    $0.title.lowercased().contains(
                        searchText
                            .lowercased()
                            .trimmingCharacters(in: .whitespaces)
                    ) ||
                    searchText.contains("\($0.grade)")
                })
                .sorted(by: { $0.title < $1.title })
        }
    }
}
