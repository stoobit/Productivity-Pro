//
//  FolderViewMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.23.
//

import SwiftUI

extension DocumentView {
    
    func importPro(url: URL) throws {
        let encodedData = try Data(contentsOf: url)
        let data = Data(base64Encoded: encodedData, options: .ignoreUnknownCharacters)
        
        let document = try JSONDecoder().decode(Document.self, from: data ?? Data())
        let documentTitle = url.deletingPathExtension().lastPathComponent
        
        let contentObject = ContentObject(
            id: UUID(), title: getTitle(with: documentTitle), type: .file,
            parent: parent, created: Date(), grade: grade
        )
        context.insert(contentObject)
        
    }
    
    func importProNote(url: URL) throws {
        
    }
    
    func importProBackup(url: URL) throws {
        
    }
    
    func getTitle(with original: String) -> String {
        var title: String = original
        var index: Int = 1
        
        let filteredObjects = contentObjects
            .filter({
                $0.type == .file &&
                $0.parent == parent &&
                $0.grade == grade &&
                $0.inTrash == false
            })
            .map({ $0.title })
        
        
        while filteredObjects.contains(title) {
            title = "\(original) \(index)"
            index += 1
        }
        
        return title
    }
    
    func importFile(result: Result<[URL], any Error>) {
        do {
            switch result {
            case .success(let success):
                if let url = success.first {
                    if url.pathExtension == "pro" {
                        try importPro(url: url)
                    } else if url.pathExtension == "pronote" {
                        try importProNote(url: url)
                    } else if url.pathExtension == "probackup" {
                        try importProBackup(url: url)
                    }
                }
            case .failure:
                // MARK: - Disable ProgressView
                break
            }
        } catch {
            // MARK: - Disable ProgressView
        }
    }
    
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
    
    func getObjects(_ type: ContentObjectType?, isPinned: Bool) -> [ContentObject] {
        if type == .none {
            return []
        }
        
        var objects = contentObjects.filter({
            $0.parent == parent &&
            $0.grade == grade &&
            $0.isPinned == isPinned &&
            $0.inTrash == false
        })
        
        if type == .file {
            objects = objects.filter({ $0.type == .file })
        } else if type == .folder {
            objects = objects.filter({ $0.type == .folder })
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
