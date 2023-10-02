//
//  ObjectPicker.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 28.09.23.
//

import SwiftUI
import SwiftData

struct ObjectPicker: View {
    var objects: [ContentObject]
    var contentObjects: [ContentObject] {
        objects.filter({
            $0.inTrash == false &&
            $0.grade == grade
        })
    }
    
    @AppStorage("ppgrade")
    var grade: Int = 5
    
    @Binding var isPresented: Bool
    var id: UUID?
    
    @State var selectedObject: String = ""
    
    var type: ContentObjectType
    let action: (String) -> Void
    
    var body: some View {
        NavigationStack {
            VStack {
                ObjectPickerList(
                    contentObjects: contentObjects,
                    isPresented: $isPresented,
                    selectedObject: $selectedObject, 
                    parent: "root",
                    title: "Notizen",
                    id: id,
                    type: type
                )
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen") { isPresented.toggle() }
                }
            }
        }
    }
}
