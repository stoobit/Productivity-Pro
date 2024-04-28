//
//  HomeworkEditViewMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 28.04.24.
//

import SwiftUI

extension HomeworkEditView {
    func set() {
        title = homework.title
        date = homework.date
        pickedNote = homework.note?.id.uuidString ?? ""
        description = homework.homeworkDescription
    }
    
    func edit() {
        homework.title = title
        homework.date = date
        homework.note = contentObjects.first(where: {
            $0.id.uuidString == pickedNote
        })
        
        homework.homeworkDescription = description
            
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(
                withIdentifiers: [homework.id.uuidString]
            )
            
        pushNotification()
        try? context.save()
    }
    
    func getSubject(from title: String) -> Subject {
        var subject = Subject()
        
        if let s = subjects.value.first(where: {
            $0.title == title
        }) {
            subject = s
        } else {
            subject = Subject(title: "", icon: "", color: Color.clear.rawValue)
        }
        
        return subject
    }
    
    func pushNotification() {
        let content = UNMutableNotificationContent()
        content.sound = UNNotificationSound.default
        content.title = homework.title
        content.body = String(localized: "Diese Aufgabe ist bis morgen in \(homework.subject) zu erledigen.")

        let calendar = Calendar.current
        let date = Calendar.current.date(
            byAdding: .day, value: -1, to: homework.date
        )!
        
        let component = DateComponents(
            calendar: calendar,
            timeZone: .current,
            year: calendar.component(.year, from: date),
            month: calendar.component(.month, from: date),
            day: calendar.component(.day, from: date),
            hour: calendar.component(.hour, from: notificationTime),
            minute: calendar.component(.minute, from: notificationTime)
        )
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: component, repeats: false
        )
        
        let request = UNNotificationRequest(
            identifier: homework.id.uuidString,
            content: content, trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }
    
    func edgeInsets() -> EdgeInsets {
        var insets = EdgeInsets()
        let value: CGFloat = 5
        
        insets.leading = value
        insets.trailing = value
        
        return insets
    }
}
