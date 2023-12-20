//
//  ImportPro.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 18.12.23.
//

import PencilKit
import SwiftUI

extension ObjectView {
    func importPro(url: URL) throws {
        if url.startAccessingSecurityScopedResource() {
            let encodedData = try Data(contentsOf: url)
            let data = Data(base64Encoded: encodedData, options: .ignoreUnknownCharacters)
            
            let document = try JSONDecoder().decode(Document.self, from: data ?? Data())
            let documentTitle = url.deletingPathExtension().lastPathComponent
            
            let contentObject = ContentObject(
                id: UUID(), title: getTitle(with: documentTitle), type: .file,
                parent: parent, created: fileCreationDate(url: url), grade: grade
            )
            
            defer {
                url.stopAccessingSecurityScopedResource()
            }
            
            context.insert(contentObject)
            contentObject.note = PPNoteModel()
            
            for page in document.note.pages {
                let ppPage = PPPageModel(
                    type: transferPageType(type: page.type),
                    index: contentObject.note!.pages!.count
                )
                
                ppPage.note = contentObject.note
                
                ppPage.title = page.header ?? ""
                ppPage.created = page.date ?? Date()
                
                ppPage.isPortrait = page.isPortrait
                ppPage.template = page.backgroundTemplate
                ppPage.color = page.backgroundColor
                
                ppPage.canvas = page.canvas
                ppPage.items = [PPItemModel]()
                
                if page.type == .image || page.type == .pdf {
                    if let data = page.backgroundMedia {
                        let image = UIImage(data: data)
                        ppPage.media = image?.heicData()
                    }
                }
                
                var index = 0
                for item in page.items {
                    do {
                        let ppItem = try PPItemModel(
                            index: index,
                            type: transferItemType(type: item.type)
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
                            
                            let image = UIImage(data: media.media)
                            guard let data = image?.heicData() else { continue }
                            
                            let ppMedia = PPMediaModel(media: data)
                            ppItem.media = ppMedia
                                
                            ppMedia.stroke = media.showStroke
                            ppMedia.strokeColor = media.strokeColor
                            ppMedia.strokeWidth = media.strokeWidth
                                
                            ppMedia.rotation = item.rotation
                            ppMedia.cornerRadius = media.cornerRadius
                            
                        } else if item.type == .textField {
                            guard let textField = item.textField else { continue }
                            
                            let ppTextField = PPTextFieldModel(
                                textColor: Color(data: textField.fontColor),
                                font: textField.font,
                                fontSize: textField.fontSize
                            )
                            ppItem.textField = ppTextField
                            
                            ppTextField.string = textField.text
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

    func transferShapeType(type: ShapeType) -> PPShapeType {
        switch type {
        case .rectangle:
            return .rectangle
        case .circle:
            return .circle
        case .triangle:
            return .triangle
        case .hexagon:
            return .triangle
        }
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
