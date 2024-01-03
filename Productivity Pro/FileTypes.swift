//
//  FileTypes.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.12.23.
//

import Foundation
import UniformTypeIdentifiers
import SwiftUI

extension UTType {
    static var pro: UTType {
        UTType(importedAs: "com.till-bruegmann.Productivity-Pro.pro")
    }
}

extension UTType {
    static var pronote: UTType {
        UTType(importedAs: "com.till-bruegmann.Productivity-Pro.pronote")
    }
}

extension UTType {
    static var probackup: UTType {
        UTType(importedAs: "com.till-bruegmann.Productivity-Pro.probackup")
    }
}

struct BackupFile: FileDocument {
    static var readableContentTypes = [UTType.probackup]
    var data: Data = Data()

    init(data: Data) {
        self.data = data
    }

    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            guard let encryptedData = Data(base64Encoded: data) else { return }
            self.data = encryptedData
        }
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let secureData = data.base64EncodedData()
        return FileWrapper(regularFileWithContents: secureData)
    }
}
