//
//  ContentObject.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.23.
//

import Foundation

struct ContentObject: Identifiable, Codable {
    var id: UUID = UUID()
    var fileType: FileType
}

enum FileType: Codable {
    case folder
    case pro
    case pdf
}
