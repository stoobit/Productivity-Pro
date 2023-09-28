//
//  ObjectPicker.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 28.09.23.
//

import SwiftUI
import SwiftData

struct ObjectPicker: View {
    @Query(
        filter: #Predicate<ContentObject> {
            $0.inTrash == false
        },
        sort: [
            SortDescriptor(\ContentObject.title)
        ],
        animation: .bouncy
    ) var contentObjects: [ContentObject]
    
    @Binding var isPresented: Bool
    @Binding var selectedObject: ContentObject?
    
    var body: some View {
        NavigationStack {
            ObjectPickerList(
                contentObjects: contentObjects,
                selectedObject: $selectedObject,
                isPresented: $isPresented,
                parent: "root",
                title: "Notizen"
            )
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen") { isPresented.toggle() }
                }
            }
        }
    }
}
