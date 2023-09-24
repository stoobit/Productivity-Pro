//
//  Folder.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.09.23.
//

import SwiftData
import Foundation

@Model final class TopLevelFolder {
    
    init(title: String, topLevel: Bool, date: Date) {
        self.title = title
        self.date = date
        self.dateChanged = date
    }
    
    var title: String
    var date: Date
    var dateChanged: Date
    
    var folders: [Folder] = []
    var documents: [Document] = []
    
}
