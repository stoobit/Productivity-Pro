//
//  TrashView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.09.23.
//

import SwiftUI
import SwiftData

struct TrashView: View {
    @Environment(\.modelContext) var context
    @State var emptyTrash: Bool = false
    
    var contentObjects: [ContentObject]
    var filteredObjects: [ContentObject] {
        contentObjects
            .filter { $0.inTrash }
            .sorted(by: {
                $0.title < $1.title
            })
            .sorted(by: {
                $0.grade < $1.grade
            })
    }
    
    var body: some View {
        List {
            ForEach(filteredObjects) { object in
                TrashViewItem(
                    contentObjects: contentObjects, object: object
                )
            }
            
            if filteredObjects.isEmpty {
                Text("")
                    .listRowBackground(Color.clear)
            }
        }
        .scrollDisabled(filteredObjects.isEmpty)
        .environment(\.defaultMinListRowHeight, 10)
        .navigationTitle("Papierkorb")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Entleeren", role: .destructive) {
                    emptyTrash.toggle()
                }
                .tint(Color.red)
                .disabled(filteredObjects.isEmpty)
            }
        }
        .alert("Papierkorb entleeren", isPresented: $emptyTrash, actions: {
            Button("Abbrechen", role: .cancel) {
                emptyTrash = false
            }
            
            Button("Entleeren", role: .destructive) {
                withAnimation(.smooth(duration: 0.2)) {
                    for filteredObject in filteredObjects {
                        context.delete(filteredObject)
                    }
                }
                
                emptyTrash = false
            }
        }) {
            Text("Möchtest du den Papierkorb wirklich entleeren?")
        }
        .overlay {
            if filteredObjects.isEmpty {
                ContentUnavailableView(
                    "Der Papierkorb ist leer.", systemImage: "trash"
                )
            }
        }
    }
}
