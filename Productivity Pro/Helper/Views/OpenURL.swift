//
//  OpenURL.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 05.01.24.
//

import SwiftUI

struct OpenURL: ViewModifier {
    @Environment(ToolManager.self) var toolManager
    @Environment(SubviewManager.self) var subviewManager
    @Environment(\.modelContext) var context

    @AppStorage("ppgrade") var grade: Int = 5
    var objects: [ContentObject]

    @State var parent: String = ""
    @State var url: URL?

    @State var showPicker: Bool = false
    @State var showAlert: Bool = false
    
    var contentObjects: [ContentObject]

    func body(content: Content) -> some View {
        content
            .onOpenURL(perform: { url in
                if url.scheme == "productivitypro" {
                    return
                }
                
                self.url = url
                if url.pathExtension == "pronote" {
                    toolManager.pencilKit = false
                    
                    subviewManager.sharePDFView = false
                    subviewManager.shareProView = false
                    subviewManager.showInspector = false
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        showPicker = true
                    }
                } else {
                    showAlert.toggle()
                }
            })
            .sheet(isPresented: $showPicker, content: {
                ObjectPicker(
                    objects: objects,
                    isPresented: $showPicker, id: UUID(),
                    selectedObject: $parent, type: .folder
                )
            })
            .onChange(of: parent) {
                ppImport()
            }
            .alert("Import nicht möglich", isPresented: $showAlert, actions: {
                Button("Ok", role: .cancel) {
                    showAlert.toggle()
                }
            }) {
                Text("Bitte importiere die Datei über das Import-Menü oder die Backup-Ansicht.")
            }
    }

    func ppImport() {
        if let url = url {
            toolManager.showProgress = true

            do {
                try pronoteImport(url: url)

                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                    toolManager.showProgress = false
                }
            } catch {
                toolManager.showProgress = false
            }
        }
    }

    func pronoteImport(url: URL) throws {
        let importer = ImportManager()
        let importable = try importer.ppImport(
            from: url,
            to: parent,
            with: grade, 
            contentObjects: contentObjects
        )
        
        importable.title = getTitle(with: importable.title)

        context.insert(importable)

        self.url = nil
        parent = ""
    }
    
    func getTitle(with original: String) -> String {
        var title: String = original
        var index = 1

        let filteredObjects = contentObjects
            .filter {
                $0.type == COType.file.rawValue &&
                    $0.parent == parent &&
                    $0.grade == grade &&
                    $0.inTrash == false
            }
            .map { $0.title }

        while filteredObjects.contains(title) {
            title = "\(original) \(index)"
            index += 1
        }

        return title
    }
}
