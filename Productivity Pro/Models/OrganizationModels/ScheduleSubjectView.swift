//
//  ScheduleSubjectView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 22.09.23.
//

import Foundation

struct ScheduleSubject: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    
    var subject: String = ""
    var room: String = ""
    
    var isMarked: Bool = false
    
    init(subject: LocalizedStringResource, room: String) {
        self.subject = String(localized: subject)
        self.room = room
    }
    
    init(_ subject: String, room: String) {
        self.subject = subject
        self.room = room
    }
    
    init() {
        
    }
}
