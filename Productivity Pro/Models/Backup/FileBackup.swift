//
//  FileBackup.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.23.
//

import Foundation

struct FileBackup: Identifiable, Codable {
    var id: UUID
    var title: String
    var date: Date
    var dateChanged: Date
    var grade: Int
    var subject: UUID?
    var document: Document
}
