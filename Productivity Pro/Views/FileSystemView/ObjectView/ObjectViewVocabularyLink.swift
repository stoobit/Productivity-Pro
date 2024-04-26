//
//  ObjectViewVocabularyLink.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.04.24.
//

import SwiftUI

struct ObjectViewVocabularyLink: View {
    var contentObjects: [ContentObject]
    @Bindable var object: ContentObject
    var swipeAction: Bool = true
    
    @Environment(ToolManager.self) var toolManager
    @Environment(SubviewManager.self) var subviewManager
    @AppStorage("ppgrade") var grade: Int = 5
    
    let delete: () -> Void
    
    @State var isMove: Bool = false
    @State var isRename: Bool = false
    @State var selectedObject: String = ""
    
    var body: some View {
        NavigationLink(destination: {
           VocabularyViewContainer(object: object)
        }) {
            ContentObjectLink(obj: object)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            if swipeAction {
                Button(role: .destructive, action: {
                    withAnimation(.bouncy) {
                        object.isPinned.toggle()
                    }
                }) {
                    Image(systemName: !object.isPinned ? "pin.fill" : "pin.slash.fill"
                    )
                }
                .tint(Color.accentColor)
            }
        }
        .contextMenu {
            Section {
                NavigationLink(destination: {
                    VocabularyViewContainer(object: object)
                }) {
                    Label(
                        "Öffnen",
                        systemImage: "rectangle.portrait.and.arrow.forward"
                    )
                }
            }
            
            Section {
                Button("Umbenennen", systemImage: "pencil") {
                    isRename = true
                }
                
                Button("Bewegen", systemImage: "folder") {
                    isMove = true
                }
            }
            
            Button(role: .destructive, action: {
                withAnimation(.bouncy) {
                    delete()
                }
            }) {
                Label("Entfernen", systemImage: "trash")
            }
        }
        .modifier(
            RenameContentObjectView(
                contentObjects: contentObjects,
                object: object,
                isPresented: $isRename
            )
        )
        .sheet(isPresented: $isMove, onDismiss: move) {
            ObjectPicker(
                objects: contentObjects,
                isPresented: $isMove,
                id: object.id,
                selectedObject: $selectedObject, type: .folder
            )
        }
    }
    
    func move() {
        if selectedObject.isEmpty == false {
            var value: String = object.title
            var index: Int = 1
            
            let filteredObjects = contentObjects
                .filter {
                    $0.type == object.type &&
                        $0.parent == selectedObject &&
                        $0.grade == grade &&
                        $0.inTrash == false
                }
                .map { $0.title }
            
            while filteredObjects.contains(value) {
                value = "\(object.title) \(index)"
                index += 1
            }
            
            withAnimation(.bouncy) {
                object.parent = selectedObject
                object.title = value
            }
            
            selectedObject = ""
        }
    }
}