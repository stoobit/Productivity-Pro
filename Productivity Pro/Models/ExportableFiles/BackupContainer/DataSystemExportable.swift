//
//  ProductivityBackup.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.23.
//

import Foundation

struct DataSystemExportable: Codable {
    var contentObjects: [ContentObjectExportable] = []
}
