//
//  Folder.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.09.23.
//

import SwiftData
import Foundation

@Model final class Folder {
    
    init() { }
    
    var subject: String?
    
    var folders: [Folder] = []
    var documents: [Document] = []
    
}
