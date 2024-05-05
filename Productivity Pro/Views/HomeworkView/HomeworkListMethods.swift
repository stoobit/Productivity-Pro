//
//  HomeworkListMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 22.09.23.
//

import SwiftUI

extension HomeworkList {
    func check() {
        for homework in homeworkTasks {
            if Calendar.current.isDateInYesterday(homework.date) {
                context.delete(homework)
            }
        }
    }
    
    func delete(_ homework: Homework) {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(
                withIdentifiers: [homework.id.uuidString]
            )
        
        context.delete(homework)
    }
    
    func edit(_ homework: Homework) {
        selectedHomework = homework
        presentEdit.toggle()
    }
    
    func dates() -> [Date] {
        if isUnlocked {
            let dates = homeworkTasks.map { $0.date }
            return Array(Set(dates)).sorted(by: { $0 < $1 })
        } else {
            let dates = preview.map { $0.date }
            return Array(Set(dates)).sorted(by: { $0 < $1 })
        }
    }
    
    func formattedString(of date: Date) -> LocalizedStringKey {
        let calendar = Calendar.current
        
        if calendar.numberOfDaysBetween(Date(), and: date) > 7 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = String(localized: "d. MMMM")
            
            return "Bis zum \(dateFormatter.string(from: date)) zu erledigen"
            
        } else if calendar.numberOfDaysBetween(Date(), and: date) == 0 {
            return "Bis heute zu erledigen"
        } else if calendar.numberOfDaysBetween(Date(), and: date) == 1 {
            return "Bis morgen zu erledigen"
        } else {
            let formatter = DateFormatter()
            let day = formatter.weekdaySymbols[
                Calendar.current.component(.weekday, from: date) - 1
            ]
            
            return "Bis \(day) zu erledigen"
        }
    }
    
    func filterTasks(by date: Date) -> [Homework] {
        if isUnlocked {
            let filtered = homeworkTasks.filter { $0.date == date }
            return filtered.sorted(by: {
                $0.subject < $1.subject
            })
        } else {
            let filtered = preview.filter { $0.date == date }
            return filtered.sorted(by: {
                $0.subject < $1.subject
            })
        }
    }
}
