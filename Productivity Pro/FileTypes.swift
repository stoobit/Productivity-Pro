//
//  FileTypes.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.12.23.
//

import Foundation
import UniformTypeIdentifiers

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
