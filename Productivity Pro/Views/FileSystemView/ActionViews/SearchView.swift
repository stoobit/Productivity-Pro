//
//  SearchView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.09.23.
//

import SwiftUI
import SwiftData

struct SearchView: View {
    @Query(
        filter: #Predicate<ContentObject> {
            $0.inTrash == false
        },
        sort: [SortDescriptor(\ContentObject.title)],
        animation: .bouncy
    ) var contentObjects: [ContentObject]
    
    @State var searchText: String = ""
    
    var body: some View {
        Form {
            ForEach(searchResults) { object in
                
            }
        }
        .environment(\.defaultMinListRowHeight, 30)
        .navigationTitle("Suchen")
        .navigationBarTitleDisplayMode(.large)
        .searchable(text: $searchText) {
            ForEach(searchResults, id: \.self) { result in
                Text("Are you looking for \(result.title)?")
                    .searchCompletion(result.title)
            }
        }
    }
    
    var searchResults: [ContentObject] {
        if searchText.isEmpty {
            return contentObjects
        } else {
            return contentObjects.filter {
                $0.title.contains(searchText)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SearchView()
    }
}
