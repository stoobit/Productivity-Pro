//
//  OpenURL.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 05.01.24.
//

import SwiftUI

struct OpenURL: ViewModifier {
    @Environment(ToolManager.self) var toolManager
    @Environment(\.modelContext) var context

    @AppStorage("ppgrade") var grade: Int = 5
    var objects: [ContentObject]

    @State var parent: String = ""
    @State var url: URL?

    @State var showPicker: Bool = false
    @State var showAlert: Bool = false

    func body(content: Content) -> some View {
        content
            .onOpenURL(perform: { url in
                self.url = url
                if url.pathExtension == "pronote" {
                    showPicker.toggle()
                } else {
                    showAlert.toggle()
                }
            })
            .sheet(isPresented: $showPicker, content: {
                ObjectPicker(
                    objects: objects,
                    isPresented: $showPicker,
                    selectedObject: $parent,
                    type: .folder
                )
            })
            .onChange(of: parent) {
                ppImport()
            }
            .alert("Import nicht möglich", isPresented: $showAlert, actions: {
                Button("Verstanden", role: .cancel) {
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
            with: grade
        )

        context.insert(importable)

        self.url = nil
        parent = ""
    }
}
