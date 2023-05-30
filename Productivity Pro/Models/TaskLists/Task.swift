//
//  Task.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 13.12.22.
//

import Foundation

struct TaskItem: Codable, Identifiable {
    var id: UUID = UUID()
    
    var title: String = ""
    var description: String = ""
    
    var priority: Priority = .none
    
    var dateEnabled: Bool = false
    var date: Date = Date()
    
    var timeEnabled: Bool = false
    var time: Date = Date()
    
    var url: String = ""
    
    var document: Document
    
}

enum Priority: Int, Codable {
    case none = 0
    case low = 1
    case medium = 2
    case high = 3
}
