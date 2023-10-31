//
//  FolderViewMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.23.
//

import SwiftUI
import PencilKit
import SwiftyMarkdown

extension ObjectView {
    
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
        contentObject.note = PPNoteModel()
        
        for page in document.note.pages {
            let ppPage = PPPageModel(
                type: transferPageType(type: page.type),
                canvas: .pkCanvas,
                index: contentObject.note!.pages!.count
            )
            
            ppPage.note = contentObject.note
            
            ppPage.title = page.header ?? ""
            ppPage.created = page.date ?? Date()
            
            ppPage.isPortrait = page.isPortrait
            ppPage.template = page.backgroundTemplate
            ppPage.color = page.backgroundColor
            
            ppPage.pkCanvas = page.canvas
            ppPage.items = [PPItemModel]()
            
            if page.type == .image || page.type == .pdf {
                ppPage.media = page.backgroundMedia
            }
            
            var index = 0
            for item in page.items {
                do {
                    
                    let ppItem = PPItemModel(
                        index: index,
                        type: try transferItemType(type: item.type)
                    )
                    
                    ppItem.page = ppPage
                    ppItem.isLocked = item.isLocked ?? false
                    
                    ppItem.width = item.width
                    ppItem.height = item.height
                    
                    ppItem.x = item.x
                    ppItem.y = item.y
                    
                    if item.type == .shape {
                        guard let shape = item.shape else { continue }
                        
                        let ppShape = PPShapeModel(type: transferShapeType(type: shape.type))
                        ppItem.shape = ppShape
                        
                        ppShape.fill = shape.showFill
                        ppShape.fillColor = shape.fillColor
                        
                        ppShape.stroke = shape.showStroke
                        ppShape.strokeColor = shape.strokeColor
                        ppShape.strokeWidth = shape.strokeWidth
                        
                        ppShape.rotation = item.rotation
                        ppShape.cornerRadius = shape.cornerRadius
                        
                    } else if item.type == .media {
                        guard let media = item.media else { continue }
                        
                        let ppMedia = PPMediaModel(media: media.media)
                        ppItem.media = ppMedia
                        
                        ppMedia.stroke = media.showStroke
                        ppMedia.strokeColor = media.strokeColor
                        ppMedia.strokeWidth = media.strokeWidth

                        ppMedia.rotation = item.rotation
                        ppMedia.cornerRadius = media.cornerRadius
                        
                    } else if item.type == .textField {
                        guard let textField = item.textField else { continue }
                        
                        let ppTextField = PPTextFieldModel()
                        
                        ppItem.textField = ppTextField
                        ppTextField.nsAttributedString = markdown(textField: textField)
                            .toCodable()
                        
                        ppTextField.fill = textField.showFill
                        ppTextField.fillColor = textField.fillColor
                        
                        ppTextField.stroke = textField.showStroke
                        ppTextField.strokeColor = textField.strokeColor
                        ppTextField.strokeWidth = textField.strokeWidth
                    }
                } catch {
                    continue
                }
                
                index += 1
            }
        }
    }
    
    func importProNote(url: URL) throws {
        
    }
    
    func importProBackup(url: URL) throws {
        
    }
    
    func transferPageType(type: PageType) -> PPPageType {
        switch type {
        case .recent:
            return .template
        case .template:
            return .template
        case .pdf:
            return .pdf
        case .image:
            return .image
        }
    }
    
    func transferItemType(type: ItemType) throws -> PPItemType {
        switch type {
        case .shape:
            return .shape
        case .textField:
            return .textField
        case .media:
            return .media
        case .none:
            throw RuntimeError("none")
        }
    }
    
    func markdown(textField: TextFieldModel) -> NSAttributedString {
        let md = SwiftyMarkdown(string: textField.text)
        
        md.setFontNameForAllStyles(with: textField.font)
        md.setFontSizeForAllStyles(with: textField.fontSize * 2)
        md.setFontColorForAllStyles(
            with: UIColor(Color(data: textField.fontColor))
        )
        
        md.code.color = UIColor(Color("codecolor"))
        md.code.fontStyle = .bold
        
        md.strikethrough.color = .red
        
        md.h6.fontSize = textField.fontSize * 2 + 5
        md.h6.fontStyle = .bold
        
        md.h5.fontSize = textField.fontSize * 2 + 10
        md.h5.fontStyle = .bold
        
        md.h4.fontSize = textField.fontSize * 2 + 15
        md.h4.fontStyle = .bold
        
        md.h3.fontSize = textField.fontSize * 2 + 20
        md.h3.fontStyle = .bold
        
        md.h2.fontSize = textField.fontSize * 2 + 25
        md.h2.fontStyle = .bold
        
        md.h1.fontSize = textField.fontSize * 2 + 30
        md.h1.fontStyle = .bold
        
        return md.attributedString()
    }
    
    func transferShapeType(type: ShapeType) -> PPShapeType {
        switch type {
        case .rectangle:
            return .rectangle
        case .circle:
            return .circle
        case .triangle:
            return .triangle
        case .hexagon:
            return.triangle
        }
    }
    
    func getTitle(with original: String) -> String {
        var title: String = original
        var index: Int = 1
        
        let filteredObjects = contentObjects
            .filter({
                $0.type == COType.file.rawValue &&
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
        if object.type == COType.folder.rawValue {
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
    
    func getObjects(_ type: COType?, isPinned: Bool) -> [ContentObject] {
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
