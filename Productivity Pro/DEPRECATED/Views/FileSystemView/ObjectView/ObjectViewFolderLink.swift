//
//  FolderViewObjectLink.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.23.
//

import SwiftUI
import UniformTypeIdentifiers

struct ObjectViewFolderLink: View {
    var contentObjects: [ContentObject]
    
    @Bindable var object: ContentObject
    let delete: () -> Void
    
    @AppStorage("ppgrade") var grade: Int = 5
    
    @State var isMove: Bool = false
    @State var isRename: Bool = false
    @State var selectedObject: String = ""
    
    @State private var isExportingPDFs = false
    @State private var pdfFolderDocument: PDFFolderDocument?
    
    var body: some View {
        NavigationLink(destination: {
            ObjectView(
                parent: object.id.uuidString, title: object.title,
                contentObjects: contentObjects
            )
        }) {
            ContentObjectLink(obj: object)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive, action: {
                withAnimation(.smooth(duration: 0.2)) {
                    object.isPinned.toggle()
                }
            }) {
                Image(systemName: !object.isPinned ? "pin.fill" : "pin.slash.fill"
                )
            }
            .tint(Color.accentColor)
        }
        .contextMenu {
            Section {
                NavigationLink(destination: {
                    ObjectView(
                        parent: object.id.uuidString,
                        title: object.title,
                        contentObjects: contentObjects
                    )
                }) {
                    Label(
                        "Öffnen",
                        systemImage: "rectangle.portrait.and.arrow.forward"
                    )
                }
            }
            
            Section {
                Button("Export All as PDFs", systemImage: "square.and.arrow.up") {
                    Task {
                        let tempURL = await generateAllPDFs(for: object)
                        pdfFolderDocument = PDFFolderDocument(folderURL: tempURL)
                        isExportingPDFs = true
                    }
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
                withAnimation(.smooth(duration: 0.2)) {
                    delete()
                }
            }) {
                Label("Löschen", systemImage: "trash")
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
                isPresented: $isMove, id: object.id,
                selectedObject: $selectedObject, type: .folder
            )
        }
        .fileExporter(
            isPresented: $isExportingPDFs,
            document: pdfFolderDocument,
            contentType: .folder,
            defaultFilename: "\(object.title) PDFs"
        ) { result in
            switch result {
            case .success(let url):
                print("Exported to \(url)")
            case .failure(let error):
                print("Export failed: \(error)")
            }
        }
    }
    
    @MainActor
    func generateAllPDFs(for folder: ContentObject) async -> URL {
        let tempUUID = UUID().uuidString
        let tempFolder = FileManager.default.temporaryDirectory
            .appendingPathComponent(tempUUID)
            .appendingPathComponent("\(sanitize(folder.title)) PDFs")
            
        try? FileManager.default.createDirectory(at: tempFolder, withIntermediateDirectories: true, attributes: nil)
        
        await processFolder(folder: folder, currentPath: sanitize(folder.title), tempFolder: tempFolder)
        
        return tempFolder
    }
    
    @MainActor
    func processFolder(folder: ContentObject, currentPath: String, tempFolder: URL) async {
        let children = contentObjects.filter { $0.parent == folder.id.uuidString && !$0.inTrash }
        
        for child in children {
            let childName = sanitize(child.title)
            
            if child.type == COType.folder.rawValue {
                let nextPath = currentPath.isEmpty ? childName : "\(currentPath)-\(childName)"
                await processFolder(folder: child, currentPath: nextPath, tempFolder: tempFolder)
            } else if child.type == COType.file.rawValue {
                let pdfName = currentPath.isEmpty ? "\(childName).pdf" : "\(currentPath)-\(childName).pdf"
                let targetURL = tempFolder.appendingPathComponent(pdfName)
                
                if let generatedURL = try? PDFManager().exportPDF(from: child) {
                    try? FileManager.default.moveItem(at: generatedURL, to: targetURL)
                }
                
                // Allow the runloop to clear autoreleasepools and view memory between large renderings
                await Task.yield()
                try? await Task.sleep(nanoseconds: 100_000_000)
            }
        }
    }

    func sanitize(_ filename: String) -> String {
        return filename.replacingOccurrences(of: "/", with: "-").replacingOccurrences(of: "\\", with: "-")
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
            
            withAnimation(.smooth(duration: 0.2)) {
                object.parent = selectedObject
                object.title = value
            }
            
            selectedObject = ""
        }
    }
}

struct PDFFolderDocument: FileDocument {
    static var readableContentTypes: [UTType] { [.folder] }
    
    var folderURL: URL
    
    init(folderURL: URL) {
        self.folderURL = folderURL
    }
    
    init(configuration: ReadConfiguration) throws {
        self.folderURL = FileManager.default.temporaryDirectory
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return try FileWrapper(url: folderURL, options: [])
    }
}
