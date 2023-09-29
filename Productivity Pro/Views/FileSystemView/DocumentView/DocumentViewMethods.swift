//
//  FolderViewMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.23.
//

import SwiftUI

extension DocumentView {
    
    func deleteObject(_ object: ContentObject) {
        object.inTrash = true
        if object.type == .folder {
            var isDeleting: Bool = true
            var parents: [[String]] = [[object.id.uuidString]]
            var index: Int = 0
            
            
            while isDeleting {
                if index < parents.count {
                    
                    for p in parents[index] {
                        parents.append([])
                        
                        let filteredObjects = contentObjects.filter({
                            $0.parent == p
                        })
                        
                        for filteredObject in filteredObjects {
                            filteredObject.inTrash = true
                            
                            if parents.indices.contains(index + 1) {
                                parents[index + 1].append(
                                    filteredObject.id.uuidString
                                )
                            }
                        }
                    }
                    
                    index += 1
                    
                } else {
                    isDeleting = false
                }
            }
        }
    }
    
    func importFile(result: Result<[URL], any Error>) {
        switch result {
        case .success(let urls):
            for url in urls {
                if url.startAccessingSecurityScopedResource() {
                    do {
                        
                        let data = try Data(contentsOf: url)
                        let title: String = String(url.lastPathComponent.dropLast(4))
                        
                        defer { url.stopAccessingSecurityScopedResource() }
                        
                        guard let decryptedData = Data(
                            base64Encoded: data, options: .ignoreUnknownCharacters
                        ) else {
                            return
                        }
                        
                        let document: Document = try JSONDecoder().decode(
                            Document.self, from: decryptedData
                        )
                        
                        let file = ContentObject(
                            id: UUID(),
                            title: title,
                            type: .file,
                            parent: parent,
                            created: Date(),
                            grade: grade
                        )
                        
                        context.insert(file)
                        
                    } catch { }
                }
            }
        case .failure:
            break
        }
    }
    
    func moveObject(_ parent: String) {
        selectedObject?.parent = parent
        selectedObject = nil
    }
    
    func getObjects(_ type: ContentObjectType?, isPinned: Bool) -> [ContentObject] {
        var objects = contentObjects.filter({
            $0.parent == parent &&
            $0.grade == grade &&
            $0.isPinned == isPinned &&
            $0.inTrash == false
        })
        
        if type != .none {
            objects = objects.filter({ $0.type == type })
        }
        
        if isReverse == false {
            switch sortType {
            case .title:
                return objects.sorted(by: { $0.title < $1.title })
            case .created:
                return objects.sorted(by: { $0.created < $1.created })
            case .modified:
                return objects.sorted(by: { $0.modified < $1.modified })
            }
        } else {
            switch sortType {
            case .title:
                return objects.sorted(by: { $0.title > $1.title })
            case .created:
                return objects.sorted(by: { $0.created > $1.created })
            case .modified:
                return objects.sorted(by: { $0.modified > $1.modified })
            }
        }
    }
    
}
