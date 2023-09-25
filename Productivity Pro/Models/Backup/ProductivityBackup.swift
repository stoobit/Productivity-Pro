//
//  ProductivityBackup.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.23.
//

import Foundation

struct ProductivityBackup: Codable {
    var files: [FileBackup]
    var folders: [FolderBackup]
}
