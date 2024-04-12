//
//  ObjectPicker.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 28.09.23.
//

import SwiftData
import SwiftUI

struct ObjectPicker: View {
    var objects: [ContentObject]
    var contentObjects: [ContentObject] {
        objects.filter {
            $0.inTrash == false &&
                $0.grade == grade
        }
    }
    
    @AppStorage("ppgrade")
    var grade: Int = 5
    
    @Binding var isPresented: Bool
    var id: UUID?
    
    @Binding var selectedObject: String
    var type: COType
    
    var body: some View {
        NavigationStack {
            VStack {
                ObjectPickerList(
                    contentObjects: contentObjects,
                    isPresented: $isPresented,
                    selectedObject: $selectedObject,
                    parent: "root",
                    title: String(localized: "Notizen"),
                    id: id,
                    type: type
                )
            }
            .scrollIndicators(.hidden)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen") { isPresented.toggle() }
                }
            }
        }
    }
}
