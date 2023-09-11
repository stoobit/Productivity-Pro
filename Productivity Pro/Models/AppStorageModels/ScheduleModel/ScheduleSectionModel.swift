//
//  ScheduleSectionModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.09.23.
//

import Foundation

struct ScheduleSection: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var subjects: [Subject] = []
}
