//
//  ExportableNoteModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 03.10.23.
//

import SwiftUI
import UniformTypeIdentifiers

public struct ExportableNoteModel: Codable {
    var pages: [ExportablePageModel] = []
}

struct ProNoteFile: FileDocument {
    static var readableContentTypes = [UTType.pronote]
    var note: ExportableNoteModel = .init()

    init(note: ExportableNoteModel = ExportableNoteModel()) {
        self.note = note
    }

    init(configuration: ReadConfiguration) throws {
        if let encodedData = configuration.file.regularFileContents {
            if let data = Data(base64Encoded: encodedData, options: .ignoreUnknownCharacters) {
                let decoder = JSONDecoder()
                note = try decoder.decode(ExportableNoteModel.self, from: data)
            }
        }
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = try JSONEncoder().encode(note)
        let secureData = data.base64EncodedData()
        
        return FileWrapper(regularFileWithContents: secureData)
    }
}
