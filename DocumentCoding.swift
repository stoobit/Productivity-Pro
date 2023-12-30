//
//  DocumentCoding.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.23.
//

import Foundation
import PPIntegrationKit

func decode(url: URL) throws -> ExportableNoteModel {
    let encodedData = try Data(contentsOf: url)
    
    let data = Data(
        base64Encoded: encodedData, options: .ignoreUnknownCharacters
    ) ?? Data()
    
    return try JSONDecoder().decode(ExportableNoteModel.self, from: data)
}

func encode(_ note: ExportableNoteModel, to url: URL) throws {
    let data = try JSONEncoder().encode(note)
    let encodedData = data.base64EncodedData()
    
    try encodedData.write(to: url)
}
