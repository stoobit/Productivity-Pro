//
//  ImportManager.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 31.12.23.
//

import Foundation
import SwiftUI

struct ImportManager {
    private func ppImport(shape: ExportableShapeModel) -> PPShapeModel {
        let importable = PPShapeModel(type: PPShapeType(rawValue: shape.type)!)
        
        importable.fill = shape.fill
        importable.fillColor = shape.fillColor
        importable.stroke = shape.stroke
        importable.strokeColor = shape.strokeColor
        importable.strokeWidth = shape.strokeWidth
        importable.strokeStyle = shape.strokeStyle
        importable.shadow = shape.shadow
        importable.shadowColor = shape.shadowColor
        importable.cornerRadius = shape.cornerRadius
        importable.rotation = shape.rotation
        
        return importable
    }
    
    private func ppImport(media: ExportableMediaModel) -> PPMediaModel {
        let importable = PPMediaModel(media: media.media)
        
        importable.stroke = media.stroke
        importable.strokeColor = media.strokeColor
        importable.strokeWidth = media.strokeWidth
        importable.strokeStyle = media.strokeStyle
        importable.shadow = media.shadow
        importable.shadowColor = media.shadowColor
        importable.cornerRadius = media.cornerRadius
        importable.rotation = media.rotation
        
        return importable
    }
    
    private func ppImport(textField: ExportableTextFieldModel) -> PPTextFieldModel {
        let importable = PPTextFieldModel()
        #warning("NSAttributedString")
        
        importable.string = textField.string
        importable.fill = textField.fill
        importable.fillColor = textField.fillColor
        importable.stroke = textField.stroke
        importable.strokeColor = textField.strokeColor
        importable.strokeWidth = textField.strokeWidth
        importable.strokeStyle = textField.strokeStyle
        importable.shadow = textField.shadow
        importable.shadowColor = textField.shadowColor
        importable.cornerRadius = textField.cornerRadius
        importable.rotation = textField.rotation
        
        return importable
    }
    
    func ppImport(item: ExportableItemModel) -> PPItemModel {
        let importable = PPItemModel(
            index: item.index,
            type: PPItemType(rawValue: item.type)!
        )
        
        importable.id = item.id
        
        importable.isLocked = item.isLocked
        importable.x = item.x
        importable.y = item.y
        importable.width = item.width
        importable.height = item.height
        
        if importable.type == PPItemType.shape.rawValue {
            importable.shape = ppImport(shape: item.shape!)
        } else if importable.type == PPItemType.media.rawValue {
            importable.media = ppImport(media: item.media!)
        } else if importable.type == PPItemType.textField.rawValue {
            importable.textField = ppImport(textField: item.textField!)
        }
        
        importable.page = nil
        return importable
    }
    
    private func ppImport(page: ExportablePageModel) -> PPPageModel {
        let importable = PPPageModel(
            type: PPPageType(rawValue: page.type)!,
            index: page.index
        )
        
        importable.id = page.id
        importable.title = page.title
        importable.created = page.created
        importable.isBookmarked = page.isBookmarked
        importable.template = page.template
        importable.color = page.color
        importable.isPortrait = page.isPortrait
        importable.media = page.media
        importable.canvas = page.canvas
        importable.items = .init()
        
        var items: [PPItemModel] = []
        for item in page.items {
            items.append(ppImport(item: item))
        }
        
        importable.items = items
        
        return importable
    }
    
    private func ppImport(note: ExportableNoteModel) -> PPNoteModel {
        let importable = PPNoteModel()
        
        var pages: [PPPageModel] = []
        for page in note.pages {
            pages.append(ppImport(page: page))
        }
        
        importable.pages = pages
        return importable
    }
    
    func ppImport(contentObject: ExportableContentObjectModel) -> ContentObject {
        let importable = ContentObject(
            id: contentObject.id,
            title: contentObject.title,
            type: COType(rawValue: contentObject.type)!,
            parent: contentObject.parent,
            created: contentObject.created,
            grade: contentObject.grade,
            subject: contentObject.subject
        )
        
        importable.modified = contentObject.modified
        importable.isPinned = contentObject.isPinned
        importable.inTrash = contentObject.inTrash
        
        if contentObject.type == COType.file.rawValue, let note = contentObject.note {
            importable.note = ppImport(note: note)
        }
        
        return importable
    }
    
    func ppImport(from url: URL, to parent: String, with grade: Int) throws -> ContentObject {
        if url.startAccessingSecurityScopedResource() {
            let title: String = url.deletingPathExtension().lastPathComponent
            let attr = try FileManager.default.attributesOfItem(atPath: url.path)
            
            let created = attr[FileAttributeKey.creationDate] as! Date
            let modified = attr[FileAttributeKey.modificationDate] as! Date
            
            let encodedData = try Data(contentsOf: url)
            
            guard let data = Data(
                base64Encoded: encodedData, options: .ignoreUnknownCharacters
            ) else {
                throw RuntimeError("Import failed.")
            }
            
            let importable = try JSONDecoder().decode(ExportableNoteModel.self, from: data)
            let note = ImportManager().ppImport(note: importable)
            
            let contentObject = ContentObject(
                id: UUID(),
                title: title,
                type: .file,
                parent: parent,
                created: created,
                grade: grade
            )
            
            contentObject.modified = modified
            contentObject.note = note
            
            defer { url.stopAccessingSecurityScopedResource() }
            return contentObject
            
        } else {
            throw RuntimeError("Import failed.")
        }
    }
}
