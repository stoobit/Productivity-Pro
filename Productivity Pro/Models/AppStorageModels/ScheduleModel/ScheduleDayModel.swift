//
//  ScheduleDayModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.09.23.
//

import Foundation

struct ScheduleDay: Identifiable, Codable, Equatable {
    
    var id: String
    var sections: [ScheduleSection] = []
}
