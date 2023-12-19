//
//  FolderViewMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.23.
//

import PencilKit
import SwiftUI

extension ObjectView {
    func importFile(result: Result<[URL], any Error>) {
        toolManager.showProgress = true
        do {
            switch result {
            case .success(let success):
                try DispatchQueue.global(qos: .userInitiated).sync {
                    if let url = success.first {
                        if url.pathExtension == "pro" {
                            print("hello")
                            try importPro(url: url)
                        } else if url.pathExtension == "pronote" {
                            try importProNote(url: url)
                        } else if url.pathExtension == "probackup" {
                            try importProBackup(url: url)
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                        toolManager.showProgress = false
                    }
                }
            case .failure:
                toolManager.showProgress = false
            }
        } catch {
            toolManager.showProgress = false
        }
    }
    
    func fileCreationDate(url: URL) -> Date {
        do {
            let attr = try FileManager.default.attributesOfItem(atPath: url.path)
            return attr[FileAttributeKey.creationDate] as? Date ?? Date()
        } catch {
            return Date()
        }
    }
    
    func deleteObject(_ object: ContentObject) {
        object.inTrash = true
        if object.type == COType.folder.rawValue {
            var isDeleting: Bool = true
            var parents: [[String]] = [[object.id.uuidString]]
            var index: Int = 0
            
            while isDeleting {
                if index < parents.count {
                    for p in parents[index] {
                        parents.append([])
                        
                        let filteredObjects = contentObjects.filter {
                            $0.parent == p
                        }
                        
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
    
    func getObjects(_ type: COType?, isPinned: Bool) -> [ContentObject] {
        if type == .none {
            return []
        }
        
        var objects = contentObjects.filter {
            $0.parent == parent &&
                $0.grade == grade &&
                $0.isPinned == isPinned &&
                $0.inTrash == false
        }
        
        if type == .file {
            objects = objects.filter {
                $0.type == COType.file.rawValue
            }
        } else if type == .folder {
            objects = objects.filter {
                $0.type == COType.folder.rawValue
            }
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
