//
//  Folder.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.09.23.
//

import Foundation

struct Folder: Identifiable, Codable {
    var id = UUID()
    
    var title: String
    var date: Date
    var dateChanged: Date
    
    var folders: [Folder] = []
    var documents: [Document] = []
}
