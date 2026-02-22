//
//  TrashView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.09.23.
//

import SwiftUI
import SwiftData

struct TrashView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    @State var emptyTrash: Bool = false
    
    var contentObjects: [ContentObject]
    var filteredObjects: [ContentObject]
    
    var body: some View {
        NavigationStack {
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
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbarRole(.browser)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Entleeren", role: .destructive) {
                        emptyTrash.toggle()
                    }
                    .tint(Color.red)
                    .disabled(filteredObjects.isEmpty)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }) {
                        Label("Zurück", systemImage: "chevron.left")
                    }
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
            .onChange(of: filteredObjects.count) {
                if filteredObjects.count == 0 { dismiss() }
            }
        }
    }
}
