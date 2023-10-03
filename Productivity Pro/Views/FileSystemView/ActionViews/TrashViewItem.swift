//
//  TrashViewItem.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 03.10.23.
//

import SwiftUI

struct TrashViewItem: View {
    @Environment(\.modelContext) var context
    
    var contentObjects: [ContentObject]
    var object: ContentObject
    
    @State var putBack: Bool = false
    @State var selectedParent: String = ""
    
    var body: some View {
        HStack {
            ContentObjectLink(obj: object)
            Text("\(object.grade)")
                .foregroundStyle(Color.secondary)
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button(
                "Wiederherstellen",
                systemImage: "arrowshape.turn.up.left.fill"
            ) {
                putBack.toggle()
            }
            .tint(Color.accentColor)
            
            Button(
                "Jetzt löschen",
                systemImage: "trash",
                role: .destructive
            ) {
                context.delete(object)
            }
        }
        .sheet(isPresented: $putBack, onDismiss: putObjectBack) {
            ObjectPicker(
                objects: contentObjects,
                isPresented: $putBack,
                selectedObject: $selectedParent, type: .folder
            )
        }
    }
    
    func putObjectBack() {
        if selectedParent.isEmpty == false {
            var value: String = object.title
            var index: Int = 1
            
            let filteredObjects = contentObjects
                .filter({
                    $0.type == object.type &&
                    $0.parent == selectedParent &&
                    $0.grade == object.grade &&
                    $0.inTrash == false
                })
                .map({ $0.title })
            
            
            while filteredObjects.contains(value) {
                value = "\(object.title) \(index)"
                index += 1
            }
            
            withAnimation(.bouncy) {
                object.inTrash = false
                object.parent = selectedParent
                object.title = value
            }
        }
    }
}
