//
//  ExportableModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.12.23.
//

import SwiftUI

struct ExportableModel {
    static func write(note: ExportableNoteModel, to url: URL) throws {
        if url.startAccessingSecurityScopedResource() {
            let data = try JSONEncoder().encode(note)
            let encodedData = data.base64EncodedData()
            
            try encodedData.write(to: url)
            url.stopAccessingSecurityScopedResource()
        }
    }
    
    static func getNote(from url: URL) throws -> ExportableNoteModel {
        if url.startAccessingSecurityScopedResource() {
            let encodedData = try Data(contentsOf: url)
            defer {
                url.stopAccessingSecurityScopedResource()
            }
            
            if let data = Data(
                base64Encoded: encodedData, options: .ignoreUnknownCharacters
            ) {
                return try JSONDecoder()
                    .decode(ExportableNoteModel.self, from: data)
            } else {
                throw IntegrationError.runtimeError(
                    "The loaded data connot be converted to ExportableNoteModel."
                )
            }
        } else {
            throw IntegrationError.runtimeError(
                "Permission to access the URL denied."
            )
        }
    }
    
    public enum IntegrationError: Error {
        case runtimeError(String)
    }
}
