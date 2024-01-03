//
//  ExportableBackupModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.12.23.
//

import Foundation

struct ExportableBackupModel: Codable {
    var contentObjects: [ExportableContentObjectModel] = []
}
