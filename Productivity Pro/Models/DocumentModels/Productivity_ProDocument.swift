//
//  Productivity_ProDocument.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 15.09.22.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var pro: UTType {
        UTType(importedAs: "com.till-bruegmann.Productivity-Pro.pro")
    }
}

struct Productivity_ProDocument: FileDocument {
    var document: Document
    
    init(document: Document = Document()) {
        self.document = document
    }

    static var readableContentTypes: [UTType] { [.pro] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
          throw CocoaError(.fileReadCorruptFile)
        }
        
        let decryptedData = Data(base64Encoded: data, options: .ignoreUnknownCharacters) ?? Data()
        document = try JSONDecoder().decode(Document.self, from: decryptedData)
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = try JSONEncoder().encode(document)
        let encryptedData = data.base64EncodedData()
        
        return .init(regularFileWithContents: encryptedData)
    }
    
}
