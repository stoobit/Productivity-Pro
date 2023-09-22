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
}
