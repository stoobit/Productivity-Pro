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
        Form {
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
            .listRowBackground(Color.clear)
            
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
        .animation(.bouncy, value: searchResults)
        .environment(\.defaultMinListRowHeight, 30)
        .navigationTitle("Suchen")
        .navigationBarTitleDisplayMode(.large)
        .searchable(text: $searchText, placement: .toolbar) {
            ForEach(searchResults, id: \.self) { result in
                Text(result.title)
                    .searchCompletion(result.title)
            }
        }
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
