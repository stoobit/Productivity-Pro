//
//  HomeworkModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.09.23.
//

import Foundation

struct Homework: Identifiable, Codable, Equatable {
    
    var id: UUID = UUID()
    
    var title: String = ""
    var description: String = ""
    
    var subject: Subject = Subject(id: "empty")
    var date: Date = Date()
    
    var priority: Int = 0
    
    func recommendDateBasedOnSubject() {
        let calendar = Calendar(identifier: .gregorian)

        let weekday = 1
        let sundayComponents = DateComponents(calendar: calendar, weekday: weekday)

        let nextSunday = calendar.nextDate(after: Date(), matching: sundayComponents, matchingPolicy: .nextTime)
    }
}


